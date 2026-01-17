import 'package:audio_service/audio_service.dart';
import 'data/services/mobile_audio_handler.dart';

/// Initialize audio_service for mobile platforms (Android/iOS)
Future<void> initMobileAudioService() async {
  await AudioService.init(
    builder: () => MobileAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'top.immiq.echo_music.channel.audio',
      androidNotificationChannelName: 'Echo Music Playback',
      androidNotificationChannelDescription: 'Music playback controls',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
      androidNotificationIcon: 'drawable/ic_notification_icon',
      androidNotificationClickStartsActivity: true,
      androidStopForegroundOnPause: false,
      fastForwardInterval: const Duration(seconds: 10),
      rewindInterval: const Duration(seconds: 10),
      preloadArtwork: false,
    ),
  );
}
