import 'dart:async';

import 'package:audio_service/audio_service.dart' as audio_service_pkg;
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import 'audio_service.dart';

/// Audio service implementation using just_audio
class AudioServiceImpl extends AudioService {
  AudioServiceImpl() {
    _initListeners();
  }
  final AudioPlayer _player = AudioPlayer();
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
  Duration get position => _player.position;

  @override
  Duration get duration => _player.duration ?? Duration.zero;

  @override
  bool get isPlaying => _player.playing;

  void _initListeners() {
    // Listen to player state changes
    _player.playerStateStream.listen((state) {
      _updateState(
        isPlaying: state.playing,
        position: _player.position,
        duration: _player.duration ?? Duration.zero,
      );
    });

    // Listen to position changes
    _player.positionStream.listen((position) {
      _positionController.add(position);
      _updateState(position: position);
    });

    // Listen to duration changes
    _player.durationStream.listen((duration) {
      _durationController.add(duration ?? Duration.zero);
      _updateState(duration: duration ?? Duration.zero);
    });

    // Listen to playing state
    _player.playingStream.listen((playing) {
      _playingController.add(playing);
      _updateState(isPlaying: playing);
    });

    // Handle completion
    _player.sequenceStream.listen((sequence) {
      if (sequence == null || sequence.isEmpty && _queue.isNotEmpty) {
        // Queue finished
        _updateState(isPlaying: false);
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
    _currentState = _currentState.copyWith(
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
      // Create audio source from file
      final AudioSource source = AudioSource.uri(
        Uri.file(song.filePath),
        tag: audio_service_pkg.MediaItem(
          id: song.id,
          title: song.title,
          artist: song.artist,
          album: song.album,
          artUri: song.albumArt != null ? Uri.file(song.albumArt!.path) : null,
          duration: song.duration,
        ),
      );

      await _player.setAudioSource(source);

      // Update current song and queue
      if (!_queue.any((s) => s.id == song.id)) {
        _queue.add(song);
      }
      _currentIndex = _queue.indexWhere((s) => s.id == song.id);

      _updateState(
        currentSong: song,
        queue: List.from(_queue),
        currentIndex: _currentIndex,
      );

      await _player.play();
    } catch (e) {
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

    // Configure loop mode for just_audio
    switch (mode) {
      case RepeatMode.one:
        await _player.setLoopMode(LoopMode.one);
      case RepeatMode.all:
      case RepeatMode.off:
        await _player.setLoopMode(LoopMode.off);
    }
  }

  @override
  Future<void> toggleShuffle(bool enabled) async {
    if (enabled) {
      // Shuffle the queue but keep current song
      if (_queue.isNotEmpty && _currentIndex >= 0) {
        final currentSong = _queue[_currentIndex];
        final shuffled = List<Song>.from(_queue)..shuffle();
        _queue.clear();
        _queue.addAll(shuffled);
        _currentIndex = _queue.indexWhere((s) => s.id == currentSong.id);
      }
    } else {
      // Restore original order (not implemented for now)
      // Would need to store original order
    }
    _updateState(isShuffle: enabled, queue: List.from(_queue));
  }

  @override
  Future<void> setQueue(List<Song> songs, {int startIndex = 0}) async {
    _queue.clear();
    _queue.addAll(songs);
    _currentIndex = startIndex.clamp(0, songs.length - 1);

    _updateState(queue: List.from(_queue), currentIndex: _currentIndex);
  }

  @override
  Future<void> addToQueue(Song song) async {
    _queue.add(song);
    _updateState(queue: List.from(_queue));
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
        // Removing current song
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

      // Update current index if affected
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
    await _player.dispose();
    await _stateController.close();
    await _positionController.close();
    await _durationController.close();
    await _playingController.close();
  }
}
