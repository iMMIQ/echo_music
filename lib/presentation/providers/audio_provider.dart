import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services/audio_background_task.dart';
import '../../data/services/audio_service.dart' as app_audio;
import '../../data/services/audio_service_impl.dart';

part 'audio_provider.g.dart';

/// Audio service global instance (for background playback)
@riverpod
AudioHandler? audioHandler(AudioHandlerRef ref) {
  // Return the current handler from AudioBackgroundTask
  return AudioBackgroundTask.currentHandler;
}

/// Audio service provider
@riverpod
app_audio.AudioService audioService(AudioServiceRef ref) {
  final service = AudioServiceImpl();

  // Dispose when provider is disposed
  ref.onDispose(service.dispose);

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
