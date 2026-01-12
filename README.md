# Echo Music

<div align="center">

**A modern, cross-platform music player**

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-GPLv3-blue)](LICENSE)

Focused on local music playback and Navidrome compatibility

[Android] [Windows] [Linux]

</div>

---

## Features

### Phase 1 (MVP)
- Local music file import (file picker, folder browsing)
- Audio playback with full controls
- Playlist queue management
- Metadata extraction (ID3 tags, album art)
- Basic UI framework

### Phase 2
- Automatic media library scanning
- Equalizer with presets
- Playback history and favorites
- Search and filtering
- Background playback

### Phase 3
- Navidrome integration
- Gapless playback / crossfade
- Advanced playback controls (A-B repeat, speed control)
- Sync across devices

## Architecture

```
lib/
├── main.dart
├── core/
│   ├── constants/       # App constants
│   ├── theme/          # Theme configuration
│   ├── utils/          # Utilities
│   └── extensions/     # Dart extensions
├── data/
│   ├── models/         # Data models
│   ├── repositories/   # Data repositories
│   └── services/       # External services
├── domain/
│   ├── entities/       # Business entities
│   └── usecases/       # Business logic
├── presentation/
│   ├── providers/      # Riverpod providers
│   ├── pages/          # Full-screen pages
│   ├── widgets/        # Reusable widgets
│   └── dialogs/        # Dialogs and bottom sheets
└── l10n/              # Internationalization
```

## Tech Stack

| Category | Library |
|----------|---------|
| **State Management** | Riverpod 2.x |
| **Audio Playback** | just_audio, audio_service |
| **Database** | Hive |
| **Metadata** | id3_ffi |
| **UI/Animation** | flutter_animate, shimmer |

## Getting Started

### Prerequisites

- Flutter SDK 3.27 or higher
- Dart 3.10 or higher
- Android Studio / VS Code
- For Android: Android SDK
- For Windows: Visual Studio 2022 with C++ desktop development
- For Linux: GTK3 development libraries

### Installation

1. Clone the repository
```bash
git clone https://github.com/immiq/echo_music.git
cd echo_music
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate code
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the app
```bash
# Android
flutter run -d android

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

## Development

### Code Generation

This project uses code generation for:
- Riverpod providers
- Freezed models
- JSON serialization
- Hive adapters

Run the build runner when you make changes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Project Structure

- `core/` - Shared utilities, constants, and theme
- `data/` - Data layer (models, repositories, services)
- `domain/` - Business logic layer
- `presentation/` - UI layer (providers, pages, widgets)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev)
- [Riverpod](https://riverpod.dev)
- [just_audio](https://pub.dev/packages/just_audio)
- [Navidrome](https://www.navidrome.org)
