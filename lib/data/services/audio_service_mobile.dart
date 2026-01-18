import 'dart:async';

import 'package:audio_service/audio_service.dart' as audio_pkg;
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import 'audio_service.dart';
import 'mobile_audio_handler.dart';

/// Audio service implementation for mobile platforms (Android/iOS)
///
/// Uses just_audio + audio_service for background playback with notifications
class MobileAudioService implements AudioService {
  MobileAudioService(this._handler) {
    _initPlayer();
    _initListeners();
  }

  final MobileAudioHandler _handler;

  late final AudioPlayer _player;
  final StreamController<PlaybackState> _stateController =
      StreamController.broadcast();
  final StreamController<Duration> _positionController =
      StreamController.broadcast();
  final StreamController<Duration> _durationController =
      StreamController.broadcast();
  final StreamController<bool> _playingController =
      StreamController.broadcast();
  final StreamController<double> _volumeController =
      StreamController.broadcast();

  PlaybackState _currentState = PlaybackState.initial();
  double _volume = 1.0;
  final List<Song> _queue = [];
  int _currentIndex = -1;

  @override
  Stream<PlaybackState> get playbackStateStream => _stateController.stream;

  @override
  Stream<Duration> get positionStream => _positionController.stream;

  @override
  Stream<Duration> get durationStream => _durationController.stream;

  @override
  Stream<bool> get playingStream => _playingController.stream;

  @override
  Stream<double> get volumeStream => _volumeController.stream;

  @override
  PlaybackState get currentState => _currentState;

  @override
  Duration get position => _player.position;

  @override
  Duration get duration => _player.duration ?? Duration.zero;

  @override
  bool get isPlaying => _player.playing;

  @override
  double get volume => _volume;

  @override
  Future<void> setVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) {
      throw ArgumentError('Volume must be between 0.0 and 1.0');
    }
    _volume = volume;
    await _player.setVolume(volume);
    _volumeController.add(volume);
  }

  void _initPlayer() {
    // Use the handler's player to ensure audio_service tracks the state
    _player = _handler.player;
    debugPrint('MobileAudioService: Using handler\'s AudioPlayer');
  }

  void _initListeners() {
    // Listen to player state changes
    _player.playingStream.listen((playing) {
      _playingController.add(playing);
      _updateState(isPlaying: playing);
    });

    // Listen to position changes
    _player.positionStream.listen((position) {
      _positionController.add(position);
      _updateState(position: position);
    });

    // Listen to duration changes
    _player.durationStream.listen((duration) {
      if (duration != null) {
        _durationController.add(duration);
        _updateState(duration: duration);
      }
    });

    // Listen to completion
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (_queue.isNotEmpty) {
          skipToNext();
        }
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
      currentIndex: currentIndex ?? _currentState.currentIndex,
    );
    _stateController.add(_currentState);
  }

  @override
  Future<void> play(Song song) async {
    try {
      final mediaItem = _songToMediaItem(song);

      // Check if song is already in queue
      final existingIndex = _queue.indexWhere((s) => s.id == song.id);

      if (existingIndex == -1) {
        // Add to queue
        _queue.add(song);
        _currentIndex = _queue.length - 1;
        await _handler.addQueueItem(mediaItem);
      } else {
        // Already in queue, just update index
        _currentIndex = existingIndex;
      }

      // Update handler's media item (this triggers notification)
      _handler.mediaItem.value = mediaItem;

      // Find the index in handler's queue and seek to it
      final handlerQueueIndex = _handler.queue.value.indexWhere((item) => item.id == song.filePath);
      if (handlerQueueIndex != -1) {
        await _handler.skipToQueueItem(handlerQueueIndex);
      }

      // Start playback
      await _player.play();

      _updateState(
        currentSong: song,
        queue: List.from(_queue),
        currentIndex: _currentIndex,
      );

      debugPrint('MobileAudioService: Playing ${song.title}, queue length = ${_handler.queue.value.length}');
    } catch (e) {
      debugPrint('MobileAudioService: Failed to play song: $e');
      throw Exception('Failed to play song: $e');
    }
  }

  audio_pkg.MediaItem _songToMediaItem(Song song) {
    return audio_pkg.MediaItem(
      id: song.filePath, // Use filePath as ID
      title: song.title,
      artist: song.artist,
      album: song.album,
      artUri: song.albumArt != null ? Uri.file(song.albumArt!.path) : null,
      duration: song.duration,
      extras: {'filePath': song.filePath},
    );
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
    if (_player.position.inSeconds > 3) {
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
    await _player.setSpeed(speed);
    _updateState(playbackSpeed: speed);
  }

  @override
  Future<void> setRepeatMode(RepeatMode mode) async {
    _updateState(repeatMode: mode);

    final loopMode = switch (mode) {
      RepeatMode.one => LoopMode.one,
      RepeatMode.all => LoopMode.all,
      RepeatMode.off => LoopMode.off,
    };

    await _player.setLoopMode(loopMode);
  }

  @override
  Future<void> toggleShuffle(bool enabled) async {
    if (enabled) {
      if (_queue.isNotEmpty && _currentIndex >= 0) {
        final currentSong = _queue[_currentIndex];
        final shuffled = List<Song>.from(_queue)..shuffle();
        _queue
          ..clear()
          ..addAll(shuffled);
        _currentIndex = _queue.indexWhere((s) => s.id == currentSong.id);

        // Update audio_handler queue using the proper method
        final mediaItems = _queue.map(_songToMediaItem).toList();
        await _handler.updateQueue(mediaItems);
      }
    }
    _updateState(isShuffle: enabled, queue: List.from(_queue));
  }

  @override
  Future<void> setQueue(List<Song> songs, {int startIndex = 0}) async {
    _queue
      ..clear()
      ..addAll(songs);
    _currentIndex = startIndex.clamp(0, songs.length - 1);

    _updateState(queue: List.from(_queue), currentIndex: _currentIndex);

    // Update audio_handler queue using the proper method
    final mediaItems = _queue.map(_songToMediaItem).toList();
    await _handler.updateQueue(mediaItems);
  }

  @override
  Future<void> addToQueue(Song song) async {
    _queue.add(song);
    _updateState(queue: List.from(_queue));
    // Note: Updating audio_handler queue would require calling its methods
  }

  @override
  Future<void> addToQueueNext(List<Song> songs) async {
    if (_currentIndex >= 0 && _currentIndex < _queue.length) {
      _queue.insertAll(_currentIndex + 1, songs);
    } else {
      _queue.addAll(songs);
    }
    _updateState(queue: List.from(_queue));
  }

  @override
  Future<void> removeFromQueue(int index) async {
    if (index >= 0 && index < _queue.length) {
      _queue.removeAt(index);
      if (index == _currentIndex) {
        await stop();
        _currentIndex = -1;
      } else if (index < _currentIndex) {
        _currentIndex--;
      }
      _updateState(queue: List.from(_queue), currentIndex: _currentIndex);
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

      if (_currentIndex == oldIndex) {
        _currentIndex = newIndex;
      } else if (_currentIndex > oldIndex && _currentIndex <= newIndex) {
        _currentIndex--;
      } else if (_currentIndex < oldIndex && _currentIndex >= newIndex) {
        _currentIndex++;
      }

      _updateState(queue: List.from(_queue), currentIndex: _currentIndex);
    }
  }

  @override
  Future<void> clearQueue() async {
    await stop();
    _queue.clear();
    _currentIndex = -1;
    _updateState(queue: [], currentIndex: -1);
  }

  @override
  Future<void> dispose() async {
    // Don't dispose _player as it belongs to the handler
    // Just close the stream controllers
    await _stateController.close();
    await _positionController.close();
    await _durationController.close();
    await _playingController.close();
    await _volumeController.close();
  }
}
