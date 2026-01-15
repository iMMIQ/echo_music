import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../models/song_model.dart';

/// Audio player handler for audio_service on mobile platforms
///
/// Integrates just_audio with audio_service for background playback
class MobileAudioHandler extends BaseAudioHandler with SeekHandler {
  MobileAudioHandler() {
    _init();
  }

  late final AudioPlayer _player = AudioPlayer();

  Future<void> _init() async {
    // Configure audio session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    // Broadcast speed changes
    _player.speedStream.listen((speed) {
      playbackState.add(playbackState.value.copyWith(speed: speed));
    });

    // Broadcast the current queue
    _player.playbackEventStream.listen(_broadcastState);

    // Broadcast media item changes
    Rx.combineLatest4<int?, List<MediaItem>, bool, List<int>?, MediaItem?>(
      _player.currentIndexStream,
      queue,
      _player.shuffleModeEnabledStream,
      _player.shuffleIndicesStream,
      (index, queue, shuffleModeEnabled, shuffleIndices) {
        final queueIndex = _getQueueIndex(index, shuffleModeEnabled, shuffleIndices);
        return (queueIndex != null && queueIndex < queue.length)
            ? queue[queueIndex]
            : null;
      },
    ).whereType<MediaItem>().distinct().listen(mediaItem.add);

    debugPrint('MobileAudioHandler: Initialized with just_audio');
  }

  int? _getQueueIndex(int? currentIndex, bool shuffleModeEnabled, List<int>? shuffleIndices) {
    final effectiveIndices = _player.effectiveIndices ?? [];
    if (effectiveIndices.isEmpty) return currentIndex;
    final shuffleIndicesInv = List.filled(effectiveIndices.length, 0);
    for (var i = 0; i < effectiveIndices.length; i++) {
      shuffleIndicesInv[effectiveIndices[i]] = i;
    }
    return (shuffleModeEnabled && ((currentIndex ?? 0) < shuffleIndicesInv.length))
        ? shuffleIndicesInv[currentIndex ?? 0]
        : currentIndex;
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    final queueIndex = _getQueueIndex(
      event.currentIndex,
      _player.shuffleModeEnabled,
      _player.shuffleIndices,
    );
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: queueIndex,
    ));
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere((state) => state.processingState == AudioProcessingState.idle);
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      await _player.shuffle();
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    await _player.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // This is a simplified implementation
    // In production, you'd need to properly manage the playlist
    debugPrint('MobileAudioHandler: addQueueItem called');
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // This is a simplified implementation
    // In production, you'd need to properly manage the playlist
    debugPrint('MobileAudioHandler: addQueueItems called with ${mediaItems.length} items');
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    final audioSources = queue.map((item) {
      return AudioSource.uri(
        Uri.parse(item.id),
        tag: item,
      );
    }).toList();
    await _player.setAudioSource(ConcatenatingAudioSource(children: audioSources));
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    // This is a simplified implementation
    // In production, you'd need to properly manage the ConcatenatingAudioSource
    debugPrint('MobileAudioHandler: removeQueueItem called');
  }

  @override
  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    // Implementation for reordering queue
    // This would require manipulating the ConcatenatingAudioSource
    debugPrint('MobileAudioHandler: moveQueueItem called');
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    _player.seek(
      Duration.zero,
      index: _player.shuffleModeEnabled ? (_player.shuffleIndices![index]) : index,
    );
  }

  @override
  Future<void> dispose() async {
    await _player.dispose();
  }
}
