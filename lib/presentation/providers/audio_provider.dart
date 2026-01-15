import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services/audio_service.dart' as app_audio;

// Platform-specific imports
import 'audio_provider_mobile.dart' if (dart.library.io) 'audio_provider_desktop.dart';

part 'audio_provider.g.dart';

/// Audio service provider
@riverpod
app_audio.AudioService audioService(AudioServiceRef ref) {
  final service = createAudioService();

  // Dispose when provider is disposed
  ref.onDispose(() {
    service.dispose();
    // Mobile handler will be disposed via global variable in audio_provider_mobile.dart
  });

  return service;
}

/// Playback state stream provider
@riverpod
Stream<app_audio.PlaybackState> playbackState(PlaybackStateRef ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.playbackStateStream;
}

/// Position stream provider
@riverpod
Stream<Duration> playbackPosition(PlaybackPositionRef ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.positionStream;
}

/// Duration stream provider
@riverpod
Stream<Duration> playbackDuration(PlaybackDurationRef ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.durationStream;
}

/// Playing state stream provider
@riverpod
Stream<bool> isPlaying(IsPlayingRef ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.playingStream;
}

