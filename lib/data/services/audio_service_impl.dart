import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:audio_service/audio_service.dart' as audio_pkg;

import '../models/song_model.dart';
import 'audio_service.dart';
import 'audio_background_task.dart';

/// Audio service implementation using media_kit
///
/// On mobile platforms (Android/iOS), this integrates with audio_service
/// for background playback. On desktop, it uses media_kit directly.
class AudioServiceImpl implements AudioService {
  AudioServiceImpl() {
    _initPlayer();
    _initListeners();
  }

  late final Player _player;
  final StreamController<PlaybackState> _stateController =
      StreamController.broadcast();
  final StreamController<Duration> _positionController =
      StreamController.broadcast();
  final StreamController<Duration> _durationController =
      StreamController.broadcast();
  final StreamController<bool> _playingController =
      StreamController.broadcast();

  PlaybackState _currentState = PlaybackState.initial();
  final List<Song> _queue = [];
  int _currentIndex = -1;

  // Mobile: Get the background audio handler
  AudioPlayerHandler? get _audioHandler {
    if (!Platform.isLinux) {
      return AudioBackgroundTask.currentHandler;
    }
    return null;
  }

  void _initPlayer() {
    // On mobile, use the player from AudioBackgroundTask
    // On desktop, create a new player
    final handler = _audioHandler;
    if (handler != null && handler.player != null) {
      _player = handler.player!;
      debugPrint('AudioServiceImpl: Using AudioBackgroundTask player');
    } else {
      _player = Player();
      debugPrint('AudioServiceImpl: Created new player (desktop mode)');
    }
  }

  @override
  Stream<PlaybackState> get playbackStateStream => _stateController.stream;

  @override
  Stream<Duration> get positionStream => _positionController.stream;

  @override
  Stream<Duration> get durationStream => _durationController.stream;

  @override
  Stream<bool> get playingStream => _playingController.stream;

  @override
  PlaybackState get currentState => _currentState;

  @override
  Duration get position => _player.state.position;

  @override
  Duration get duration => _player.state.duration;

  @override
  bool get isPlaying => _player.state.playing;

  void _initListeners() {
    // Listen to player state changes
    _player.stream.playing.listen((playing) {
      _playingController.add(playing);
      _updateState(isPlaying: playing);
    });

    // Listen to position changes
    _player.stream.position.listen((position) {
      _positionController.add(position);
      _updateState(position: position);
    });

    // Listen to duration changes
    _player.stream.duration.listen((duration) {
      _durationController.add(duration);
      _updateState(duration: duration);
    });

    // Listen to completion
    _player.stream.completed.listen((completed) {
      if (completed && _queue.isNotEmpty) {
        // Track completed, move to next
        skipToNext();
      }
    });
  }

  void _updateState({
    bool? isPlaying,
    Song? currentSong,
    Duration? position,
    Duration? duration,
    double? playbackSpeed,
    RepeatMode? repeatMode,
    bool? isShuffle,
    List<Song>? queue,
    int? currentIndex,
  }) {
    _currentState = PlaybackState(
      isPlaying: isPlaying ?? _currentState.isPlaying,
      currentSong: currentSong ?? _currentState.currentSong,
      position: position ?? _currentState.position,
      duration: duration ?? _currentState.duration,
      playbackSpeed: playbackSpeed ?? _currentState.playbackSpeed,
      repeatMode: repeatMode ?? _currentState.repeatMode,
      isShuffle: isShuffle ?? _currentState.isShuffle,
      queue: queue ?? _currentState.queue,
      currentIndex: currentIndex ?? _currentIndex,
    );
    _stateController.add(_currentState);
  }

  /// Update the background audio service with current song
  void _updateBackgroundService(Song song) {
    final handler = _audioHandler;
    if (handler == null) return;

    // Create media item with file path in extras
    final mediaItem = audio_pkg.MediaItem(
      id: song.id,
      title: song.title,
      artist: song.artist,
      album: song.album,
      artUri: song.albumArt != null ? Uri.file(song.albumArt!.path) : null,
      duration: song.duration,
      displayTitle: song.title,
      displaySubtitle: song.artist,
      displayDescription: 'From ${song.album}',
      playable: true,
      extras: {'filePath': song.filePath},
    );

    // Update the media item in background service
    handler.mediaItem.value = mediaItem;
    debugPrint('AudioServiceImpl: Updated background service with ${song.title}');
  }

  /// Update the background service queue
  void _updateBackgroundQueue() {
    final handler = _audioHandler;
    if (handler == null) return;

    // Convert songs to media items
    final mediaItems = _queue.map((song) {
      return audio_pkg.MediaItem(
        id: song.id,
        title: song.title,
        artist: song.artist,
        album: song.album,
        artUri: song.albumArt != null ? Uri.file(song.albumArt!.path) : null,
        duration: song.duration,
        displayTitle: song.title,
        displaySubtitle: song.artist,
        displayDescription: 'From ${song.album}',
        playable: true,
        extras: {'filePath': song.filePath},
      );
    }).toList();

    // Update queue in background service
    handler.queue.value = mediaItems;
    debugPrint('AudioServiceImpl: Updated background queue with ${mediaItems.length} items');
  }

  @override
  Future<void> play(Song song) async {
    try {
      // Open media file with media_kit
      await _player.open(Media('file://${song.filePath}'));

      // Update current song and queue
      if (!_queue.any((s) => s.id == song.id)) {
        _queue.add(song);
        _updateBackgroundQueue();
      }
      _currentIndex = _queue.indexWhere((s) => s.id == song.id);

      _updateState(
        currentSong: song,
        queue: List.from(_queue),
        currentIndex: _currentIndex,
      );

      // Update background service
      _updateBackgroundService(song);
    } catch (e) {
      debugPrint('AudioServiceImpl: Failed to play song: $e');
      throw Exception('Failed to play song: $e');
    }
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    _updateState(isPlaying: false);
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> skipToNext() async {
    if (_queue.isEmpty) return;

    switch (_currentState.repeatMode) {
      case RepeatMode.one:
        // Restart current song
        await seek(Duration.zero);
        await _player.play();
      case RepeatMode.off:
      case RepeatMode.all:
        if (_currentIndex < _queue.length - 1) {
          _currentIndex++;
          await play(_queue[_currentIndex]);
        } else if (_currentState.repeatMode == RepeatMode.all) {
          _currentIndex = 0;
          await play(_queue[_currentIndex]);
        } else {
          await stop();
        }
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_queue.isEmpty) return;

    // If more than 3 seconds played, restart current song
    if (_player.state.position.inSeconds > 3) {
      await seek(Duration.zero);
      return;
    }

    if (_currentIndex > 0) {
      _currentIndex--;
      await play(_queue[_currentIndex]);
    } else {
      await seek(Duration.zero);
    }
  }

  @override
  Future<void> setSpeed(double speed) async {
    if (speed < 0.5 || speed > 2.0) {
      throw ArgumentError('Speed must be between 0.5 and 2.0');
    }
    await _player.setRate(speed);
    _updateState(playbackSpeed: speed);
  }

  @override
  Future<void> setRepeatMode(RepeatMode mode) async {
    _updateState(repeatMode: mode);

    // Configure playlist mode for media_kit
    switch (mode) {
      case RepeatMode.one:
        await _player.setPlaylistMode(PlaylistMode.single);
      case RepeatMode.all:
        await _player.setPlaylistMode(PlaylistMode.loop);
      case RepeatMode.off:
        await _player.setPlaylistMode(PlaylistMode.single);
    }

    // Update background service repeat mode
    final handler = _audioHandler;
    if (handler != null) {
      final audioServiceRepeatMode = switch (mode) {
        RepeatMode.one => audio_pkg.AudioServiceRepeatMode.one,
        RepeatMode.all => audio_pkg.AudioServiceRepeatMode.all,
        RepeatMode.off => audio_pkg.AudioServiceRepeatMode.none,
      };
      // Note: setRepeatMode is not directly exposed, but the playlist mode
      // in media_kit handles this
      debugPrint('AudioServiceImpl: Set repeat mode to $audioServiceRepeatMode');
    }
  }

  @override
  Future<void> toggleShuffle(bool enabled) async {
    if (enabled) {
      // Shuffle the queue but keep current song
      if (_queue.isNotEmpty && _currentIndex >= 0) {
        final currentSong = _queue[_currentIndex];
        final shuffled = List<Song>.from(_queue)..shuffle();
        _queue
          ..clear()
          ..addAll(shuffled);
        _currentIndex = _queue.indexWhere((s) => s.id == currentSong.id);
      }
    } else {
      // Restore original order (not implemented for now)
      // Would need to store original order
    }
    _updateState(isShuffle: enabled, queue: List.from(_queue));

    // Update background queue
    _updateBackgroundQueue();
  }

  @override
  Future<void> setQueue(List<Song> songs, {int startIndex = 0}) async {
    _queue
      ..clear()
      ..addAll(songs);
    _currentIndex = startIndex.clamp(0, songs.length - 1);

    _updateState(queue: List.from(_queue), currentIndex: _currentIndex);

    // Update background queue
    _updateBackgroundQueue();
  }

  @override
  Future<void> addToQueue(Song song) async {
    _queue.add(song);
    _updateState(queue: List.from(_queue));

    // Update background queue
    _updateBackgroundQueue();
  }

  @override
  Future<void> addToQueueNext(List<Song> songs) async {
    if (_currentIndex >= 0 && _currentIndex < _queue.length) {
      _queue.insertAll(_currentIndex + 1, songs);
    } else {
      _queue.addAll(songs);
    }
    _updateState(queue: List.from(_queue));

    // Update background queue
    _updateBackgroundQueue();
  }

  @override
  Future<void> removeFromQueue(int index) async {
    if (index >= 0 && index < _queue.length) {
      _queue.removeAt(index);
      if (index == _currentIndex) {
        // Removing current song
        await stop();
        _currentIndex = -1;
      } else if (index < _currentIndex) {
        _currentIndex--;
      }
      _updateState(queue: List.from(_queue), currentIndex: _currentIndex);

      // Update background queue
      _updateBackgroundQueue();
    }
  }

  @override
  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    if (oldIndex >= 0 &&
        oldIndex < _queue.length &&
        newIndex >= 0 &&
        newIndex < _queue.length) {
      final item = _queue.removeAt(oldIndex);
      _queue.insert(newIndex, item);

      // Update current index if affected
      if (_currentIndex == oldIndex) {
        _currentIndex = newIndex;
      } else if (_currentIndex > oldIndex && _currentIndex <= newIndex) {
        _currentIndex--;
      } else if (_currentIndex < oldIndex && _currentIndex >= newIndex) {
        _currentIndex++;
      }

      _updateState(queue: List.from(_queue), currentIndex: _currentIndex);

      // Update background queue
      _updateBackgroundQueue();
    }
  }

  @override
  Future<void> clearQueue() async {
    await stop();
    _queue.clear();
    _currentIndex = -1;
    _updateState(queue: [], currentIndex: -1);

    // Clear background queue
    final handler = _audioHandler;
    if (handler != null) {
      handler.clearQueue();
    }
  }

  @override
  Future<void> dispose() async {
    // Only dispose if we created the player (desktop mode)
    if (_audioHandler == null) {
      await _player.dispose();
    }
    await _stateController.close();
    await _positionController.close();
    await _durationController.close();
    await _playingController.close();
  }
}
