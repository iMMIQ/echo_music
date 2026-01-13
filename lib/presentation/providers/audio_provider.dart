import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/services/audio_service.dart';
import '../../data/services/audio_service_impl.dart';

part 'audio_provider.g.dart';

/// Audio service provider
@riverpod
AudioService audioService(AudioServiceRef ref) {
  final service = AudioServiceImpl();

  // Dispose when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}

/// Playback state stream provider
@riverpod
Stream<PlaybackState> playbackState(PlaybackStateRef ref) {
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
