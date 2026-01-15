import '../../data/services/audio_service.dart' as app_audio;
import '../../data/services/audio_service_mobile.dart';

/// Create audio service for mobile platforms
app_audio.AudioService createAudioService() {
  return MobileAudioService();
}
