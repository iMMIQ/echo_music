import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services/audio_service.dart' as app_audio;
import '../../data/services/audio_service_desktop.dart';
import '../../data/services/audio_service_mobile.dart';

// Import global handler from home_page.dart
import '../pages/home_page.dart' show globalAudioHandler;

part 'audio_provider.g.dart';

// Cached service instance to ensure singleton
app_audio.AudioService? _cachedService;

/// Create audio service based on platform (cached)
app_audio.AudioService createAudioService() {
  if (_cachedService != null) {
    return _cachedService!;
  }

  if (Platform.isAndroid || Platform.isIOS) {
    // Mobile: use just_audio + audio_service with global handler
    if (globalAudioHandler == null) {
      throw StateError('globalAudioHandler not initialized. Call initMobileAudioService() first.');
    }
    _cachedService = MobileAudioService(globalAudioHandler!);
  } else {
    // Desktop: use media_kit
    _cachedService = DesktopAudioService();
  }

  return _cachedService!;
}

/// Audio service provider
@riverpod
app_audio.AudioService audioService(AudioServiceRef ref) {
  final service = createAudioService();

  // Only dispose the service on app shutdown, not when provider is disposed
  ref.onDispose(() {
    // Don't dispose - keep the service alive for the app lifetime
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

/// Volume stream provider
@riverpod
Stream<double> volume(VolumeRef ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.volumeStream;
}
