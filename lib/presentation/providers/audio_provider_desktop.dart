import '../../data/services/audio_service.dart' as app_audio;
import '../../data/services/audio_service_desktop.dart';

/// Create audio service for desktop platforms
app_audio.AudioService createAudioService() {
  return DesktopAudioService();
}
