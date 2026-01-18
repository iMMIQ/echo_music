# media_kit Integration

## Overview

This app uses `media_kit` for audio playback on all platforms (Android, iOS, Windows, Linux, macOS).

## Architecture

```
lib/data/services/
├── audio_service.dart              # Abstract interface
├── audio_service_unified.dart      # Unified implementation using media_kit
└── media_kit_audio_handler.dart    # AudioService integration for mobile
```

## Platform-Specific Behavior

### Mobile (Android/iOS)
- Uses `media_kit` for audio playback
- Uses `audio_service` for background playback and notifications
- `MediaKitAudioHandler` bridges the two

### Desktop (Windows/Linux/macOS)
- Uses `media_kit` directly
- No background service needed

## Dependencies

```yaml
dependencies:
  media_kit: ^1.2.6
  media_kit_libs_audio: ^1.0.7  # Audio-only libraries
  audio_service: ^0.18.13       # For mobile background playback
```

## Key Differences from just_audio

1. **Volume range**: media_kit uses 0-100, just_audio used 0-1
2. **API naming**: `setRate` instead of `setSpeed`
3. **Playlist modes**: Different enum names
4. **File loading**: Uses `Media` objects instead of `AudioSource`

## Migration Notes

- just_audio was removed in favor of media_kit
- Desktop implementation unchanged (already used media_kit)
- Mobile now uses media_kit with audio_service wrapper
