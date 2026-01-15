import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:audio_service/audio_service.dart';

import '../models/song_model.dart';

/// Audio background task handler for Android/iOS background playback
///
/// NOTE: On Linux, background audio service is not needed since media_kit
/// handles audio playback directly. This is only used for mobile platforms.
class AudioBackgroundTask {
  /// Global reference to the active audio handler
  static AudioPlayerHandler? _handler;

  /// Get the current audio handler
  static AudioPlayerHandler? get currentHandler => _handler;

  /// Start the audio service (only on mobile platforms)
  static Future<void> start() async {
    // Skip background service on Linux
    if (Platform.isLinux) {
      return;
    }

    try {
      // Add timeout to prevent hanging
      _handler = await AudioService.init(
        builder: () => AudioPlayerHandler(),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'top.immiq.echo_music.channel.audio',
          androidNotificationChannelName: 'Echo Music',
          androidNotificationOngoing: true,
          androidShowNotificationBadge: true,
          androidNotificationIcon: 'mipmap/ic_launcher',
          androidNotificationClickStartsActivity: true,
          fastForwardInterval: Duration(seconds: 10),
          rewindInterval: Duration(seconds: 10),
        ),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint('AudioService.init timed out after 10 seconds, continuing without audio service');
          return AudioPlayerHandler.noop();
        },
      );
      debugPrint('AudioService initialized successfully');
    } catch (e) {
      debugPrint('AudioService.init failed: $e');
      // Don't rethrow - allow app to start even if audio service fails
    }
  }

  /// Set media item from song
  static MediaItem mediaItemFromSong(Song song) {
    return MediaItem(
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
  }
}

/// Audio player handler for audio_service (mobile only)
///
/// This handler integrates audio_service with media_kit for proper
/// background playback support on Android and iOS.
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  /// Create a no-op handler for when audio service fails to initialize
  AudioPlayerHandler.noop() : _player = null {
    debugPrint('AudioPlayerHandler: Created noop handler');
  }

  /// Create the actual handler with MediaKit player
  AudioPlayerHandler() : _player = Player() {
    // Initialize queue
    queue.value = [];
    _initPlayer();
    debugPrint('AudioPlayerHandler: Created handler with MediaKit player');
  }

  final Player? _player;
  final List<MediaItem> _queueItems = [];
  int _currentIndex = 0;

  /// Getter for the MediaKit player (used by AudioServiceImpl)
  Player? get player => _player;

  /// Getter for the current queue
  List<MediaItem> get queueItems => List.unmodifiable(_queueItems);

  /// Getter for current index
  int get currentIndex => _currentIndex;

  void _initPlayer() {
    if (_player == null) return;

    // Listen to playback state changes
    _player!.stream.playing.listen((playing) {
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        processingState: playing
            ? AudioProcessingState.ready
            : AudioProcessingState.idle,
        playing: playing,
      ));
    });

    // Listen to position changes
    _player!.stream.position.listen((position) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: position,
      ));
    });

    // Listen to duration changes
    _player!.stream.duration.listen((duration) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: _player!.state.position,
      ));
    });

    // Listen to completion for auto-advance
    _player!.stream.completed.listen((completed) {
      if (completed && _queueItems.isNotEmpty) {
        skipToNext();
      }
    });

    debugPrint('AudioPlayerHandler: MediaKit player initialized');
  }

  @override
  Future<void> play() async {
    if (_player == null) {
      debugPrint('AudioPlayerHandler: No player available (noop mode)');
      return;
    }
    debugPrint('AudioPlayerHandler: play() called');
    try {
      await _player!.play();
    } catch (e) {
      debugPrint('AudioPlayerHandler: play() failed: $e');
    }
  }

  @override
  Future<void> pause() async {
    if (_player == null) return;
    debugPrint('AudioPlayerHandler: pause() called');
    try {
      await _player!.pause();
    } catch (e) {
      debugPrint('AudioPlayerHandler: pause() failed: $e');
    }
  }

  @override
  Future<void> stop() async {
    if (_player == null) return;
    debugPrint('AudioPlayerHandler: stop() called');
    try {
      await _player!.stop();
      playbackState.add(playbackState.value.copyWith(
        processingState: AudioProcessingState.idle,
      ));
    } catch (e) {
      debugPrint('AudioPlayerHandler: stop() failed: $e');
    }
  }

  @override
  Future<void> seek(Duration position) async {
    if (_player == null) return;
    debugPrint('AudioPlayerHandler: seek(${position.inSeconds}s) called');
    try {
      await _player!.seek(position);
    } catch (e) {
      debugPrint('AudioPlayerHandler: seek() failed: $e');
    }
  }

  @override
  Future<void> skipToNext() async {
    debugPrint('AudioPlayerHandler: skipToNext() called');

    if (_queueItems.isEmpty) {
      debugPrint('AudioPlayerHandler: Queue is empty');
      return;
    }

    if (_player == null) return;

    try {
      _currentIndex = (_currentIndex + 1) % _queueItems.length;
      await _playMediaItem(_queueItems[_currentIndex]);
    } catch (e) {
      debugPrint('AudioPlayerHandler: skipToNext() failed: $e');
    }
  }

  @override
  Future<void> skipToPrevious() async {
    debugPrint('AudioPlayerHandler: skipToPrevious() called');

    if (_queueItems.isEmpty) {
      debugPrint('AudioPlayerHandler: Queue is empty');
      return;
    }

    if (_player == null) return;

    // If more than 3 seconds played, restart current track
    if (_player!.state.position.inSeconds > 3) {
      await seek(Duration.zero);
      return;
    }

    try {
      _currentIndex = (_currentIndex - 1 + _queueItems.length) % _queueItems.length;
      await _playMediaItem(_queueItems[_currentIndex]);
    } catch (e) {
      debugPrint('AudioPlayerHandler: skipToPrevious() failed: $e');
    }
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    debugPrint('AudioPlayerHandler: setRepeatMode($repeatMode) called');

    if (_player == null) return;

    final playlistMode = switch (repeatMode) {
      AudioServiceRepeatMode.one => PlaylistMode.single,
      AudioServiceRepeatMode.all => PlaylistMode.loop,
      AudioServiceRepeatMode.none || AudioServiceRepeatMode.group => PlaylistMode.single,
    };

    try {
      await _player!.setPlaylistMode(playlistMode);
    } catch (e) {
      debugPrint('AudioPlayerHandler: setRepeatMode() failed: $e');
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    debugPrint('AudioPlayerHandler: setShuffleMode($shuffleMode) called');

    // Shuffle the queue if needed
    if (shuffleMode == AudioServiceShuffleMode.all) {
      _queueItems.shuffle();
      _currentIndex = 0;
      queue.value = List.from(_queueItems);
    }
  }

  @override
  Future<void> setSpeed(double speed) async {
    if (_player == null) return;
    debugPrint('AudioPlayerHandler: setSpeed($speed) called');
    try {
      await _player!.setRate(speed);
    } catch (e) {
      debugPrint('AudioPlayerHandler: setSpeed() failed: $e');
    }
  }

  /// Play a media item
  Future<void> _playMediaItem(MediaItem item) async {
    if (_player == null) return;

    debugPrint('AudioPlayerHandler: Playing ${item.title}');

    // Update the media item
    mediaItem.value = item;

    // Extract file path from extras
    final filePath = item.extras?['filePath'] as String?;
    if (filePath == null) {
      debugPrint('AudioPlayerHandler: No filePath in media item extras');
      return;
    }

    // Play the media file
    try {
      await _player!.open(Media('file://$filePath'), play: true);
    } catch (e) {
      debugPrint('AudioPlayerHandler: Failed to play $filePath: $e');
    }
  }

  @override
  Future<void> addQueueItem(MediaItem item) async {
    _queueItems.add(item);
    queue.value = List.from(_queueItems);
    debugPrint('AudioPlayerHandler: Added to queue: ${item.title}');
  }

  @override
  Future<void> addQueueItems(List<MediaItem> items) async {
    _queueItems.addAll(items);
    queue.value = List.from(_queueItems);
    debugPrint('AudioPlayerHandler: Added ${items.length} items to queue');
  }

  /// Set the queue and optionally play the first item
  void setQueue(List<MediaItem> items, {int startIndex = 0, bool autoPlay = false}) {
    _queueItems.clear();
    _queueItems.addAll(items);
    _currentIndex = startIndex.clamp(0, items.length > 0 ? items.length - 1 : 0);
    queue.value = List.from(_queueItems);

    debugPrint('AudioPlayerHandler: Queue set with ${items.length} items');

    if (autoPlay && items.isNotEmpty && _player != null) {
      _playMediaItem(items[_currentIndex]);
    }
  }

  @override
  Future<void> removeQueueItem(MediaItem item) async {
    final index = _queueItems.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _queueItems.removeAt(index);
      queue.value = List.from(_queueItems);

      // Adjust current index if needed
      if (index < _currentIndex) {
        _currentIndex--;
      } else if (index == _currentIndex && _player != null) {
        // We removed the current playing item
        if (_queueItems.isNotEmpty) {
          _currentIndex = _currentIndex.clamp(0, _queueItems.length - 1);
          _playMediaItem(_queueItems[_currentIndex]);
        }
      }
    }
  }

  /// Clear the queue
  void clearQueue() {
    _queueItems.clear();
    _currentIndex = 0;
    queue.value = [];
    debugPrint('AudioPlayerHandler: Queue cleared');
  }

  /// Play a specific item by index
  Future<void> playIndex(int index) async {
    if (index >= 0 && index < _queueItems.length) {
      _currentIndex = index;
      await _playMediaItem(_queueItems[index]);
    }
  }
}
