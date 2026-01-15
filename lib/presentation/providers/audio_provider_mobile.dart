import '../../data/services/audio_service.dart' as app_audio;
import '../../data/services/audio_service_mobile.dart';
import '../../data/services/mobile_audio_handler.dart';

/// Global reference to the audio handler (mobile only)
MobileAudioHandler? _mobileAudioHandler;

/// Create audio service for mobile platforms
app_audio.AudioService createAudioService() {
  // Create the handler first
  _mobileAudioHandler = MobileAudioHandler();

  // Create service with handler (handler is guaranteed non-null here)
  return MobileAudioService(_mobileAudioHandler!);
}

/// Dispose mobile audio handler
void disposeMobileAudioHandler() {
  _mobileAudioHandler?.dispose();
  _mobileAudioHandler = null;
}
