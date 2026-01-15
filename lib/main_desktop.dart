/// Initialize audio_service for desktop platforms (Windows/Linux/macOS)
/// Desktop platforms use media_kit directly without audio_service
Future<void> initMobileAudioService() async {
  // No-op on desktop
  // Desktop uses media_kit directly for playback
}
