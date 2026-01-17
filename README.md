# Echo Music

<div align="center">

**A modern, cross-platform music player built with Flutter**

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-GPLv3-blue)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.2.0--alpha-orange)](https://github.com/iMMIQ/echo_music)

Focused on local music playback with future Navidrome support

[![Android](https://img.shields.io/badge/Android-✅-3DDC84?logo=android)](https://flutter.dev/multi-platform)
[![Windows](https://img.shields.io/badge/Windows-✅-0078D7?logo=windows)](https://flutter.dev/multi-platform)
[![Linux](https://img.shields.io/badge/Linux-✅-E95420?logo=linux)](https://flutter.dev/multi-platform)

**MVP Progress: 90% Complete** 🎯

</div>

---

## ✨ Features

### ✅ Currently Implemented (v0.2.0-alpha)

#### Core Playback
- 🎵 **Audio Playback** - Play, pause, skip, seek with MediaKit engine
- 📋 **Queue Management** - Add, remove, reorder songs in queue
- 🔀 **Shuffle & Repeat** - Shuffle queue, repeat modes (off/all/one)
- 🎚️ **Playback Controls** - Mini player and full-screen player
- 📊 **Progress Tracking** - Real-time position and duration
- 🔊 **Volume Control** - Volume slider with real-time adjustment

#### Library Management
- 📁 **Music Import** - File picker with multi-file selection
- 📂 **Directory Scanning** - Scan folders for audio files
- 🏷️ **Metadata Extraction** - Extract ID3 tags from 8+ formats
- 🎨 **Album Art** - Display embedded album artwork
- 🔍 **Search** - Real-time search across songs, albums, artists
- ⭐ **Favorites** - Mark and manage favorite songs
- 🕐 **Recently Played** - Track playback history

#### Playlists
- 📝 **Playlist Management** - Create, edit, delete playlists
- 🎯 **Smart Playlists** - Rule-based dynamic playlists
- 📋 **Playlist CRUD** - Full control over playlist content

#### User Interface
- 🌓 **Theme System** - Light, dark, and system themes
- 🎨 **Accent Colors** - Customizable accent colors
- 📱 **Responsive Design** - Adapts to mobile and desktop
- ✨ **Modern UI** - Material Design 3 with smooth animations
- 🎭 **Phosphor Icons** - Beautiful, consistent iconography

#### Settings
- ⚙️ **Audio Settings** - Quality preferences, crossfade options
- 📚 **Library Settings** - Music folder management
- 🎨 **Appearance Settings** - Theme and accent color customization

### 🚧 In Development

- 🔊 **Equalizer** - Audio equalizer with presets
- 📝 **Metadata Editor** - Edit song metadata
- ⏱️ **Sleep Timer** - Auto-stop playback
- 🎛️ **Desktop Controls** - MPRIS (Linux), SMTC (Windows)
- 🔔 **Android Notification Player** - Notification bar mini player (currently not working)

### ⚠️ Known Issues

- **Android Notification Mini Player**: The notification bar mini player (like Apple Music) is not displaying. Background playback works but the notification UI is missing. Attempted integration with `audio_service` package but notification still doesn't appear. This is a known limitation that needs further investigation.

### 📋 Planned (Post-MVP)

- ☁️ **Navidrome Integration** - Stream from self-hosted server
- 🔄 **Sync** - Cross-device synchronization
- 🌐 **Online Metadata** - Fetch metadata from music databases
- 📊 **Statistics** - Listening statistics and insights

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── main.dart                 # App entry point
├── core/                     # Shared utilities
│   ├── constants/           # App constants
│   ├── theme/              # Theme configuration
│   └── utils/              # Helper utilities
├── data/                    # Data layer
│   ├── models/             # Data models (Freezed)
│   │   ├── song_model.dart
│   │   ├── album_model.dart
│   │   ├── artist_model.dart
│   │   ├── playlist_model.dart
│   │   └── settings_model.dart
│   └── services/           # Service implementations
│       ├── audio_service.dart
│       ├── library_service.dart
│       ├── playlist_service.dart
│       ├── metadata_service.dart
│       ├── hive_service.dart
│       └── permission_service.dart
├── domain/                  # Business logic
│   └── services/           # Service interfaces
├── presentation/           # UI layer
│   ├── providers/          # Riverpod state providers
│   ├── pages/              # Full-screen pages
│   │   ├── home_page.dart
│   │   └── full_player_page.dart
│   └── widgets/            # Reusable widgets
│       ├── mini_player.dart
│       ├── queue_panel.dart
│       └── settings_dialogs.dart
```

### Design Patterns

- **Clean Architecture** - Layered architecture with dependency inversion
- **Repository Pattern** - Service interfaces with implementations
- **State Management** - Riverpod with code generation
- **Immutable State** - Freezed for all models
- **Dependency Injection** - Constructor injection via Riverpod

---

## 🛠️ Tech Stack

| Category | Library | Version | Purpose |
|----------|---------|---------|---------|
| **Framework** | Flutter | 3.27+ | UI framework |
| **Language** | Dart | 3.10+ | Programming language |
| **State Management** | flutter_riverpod | 2.6.0 | Reactive state |
| **Audio Playback** | media_kit | 1.1.10+ | Cross-platform audio |
| **Background Audio** | audio_service | 0.18.14 | Mobile background playback |
| **Database** | hive | 2.2.3 | Local NoSQL storage |
| **Metadata** | metadata_god | 0.5.2+ | Audio metadata extraction |
| **File Picking** | file_picker | 8.1.2 | File/folder selection |
| **Permissions** | permission_handler | 11.3.1 | Runtime permissions |
| **Icons** | phosphor_flutter | 2.1.0 | Modern icon set |
| **Animations** | flutter_animate | 4.5.0 | Declarative animations |

### Supported Audio Formats

MP3, M4A, FLAC, WAV, OGG, OPUS, WMA, AAC

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** 3.27 or higher
- **Dart** 3.10 or higher
- **Android Studio** or **VS Code** (with Flutter extension)
- For **Android**: Android SDK
- For **Windows**: Visual Studio 2022 with C++ desktop development
- For **Linux**: GTK3 development libraries

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/iMMIQ/echo_music.git
cd echo_music
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code** (Freezed models, Riverpod providers)
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
# Android
flutter run -d android

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

### Building for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# Windows
flutter build windows --release

# Linux
flutter build linux --release
```

---

## 📝 Development

### Code Generation

This project uses code generation for:
- **Riverpod providers** (`@riverpod` annotation)
- **Freezed models** (immutable data classes)
- **Hive adapters** (type adapters for database)

Run the build runner when you make changes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch for changes during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Project Status

See [ROADMAP.md](docs/ROADMAP.md) for detailed progress tracking.

**Current Progress (v0.2.0-alpha)**:
- ✅ Phase 1 (Foundation): 100% complete
- 🟡 Phase 2 (Core Playback): 90% complete
- 🟡 Phase 3 (Library Management): 90% complete
- 🟠 Phase 4 (Enhanced Features): 40% complete
- ⏸️ Phase 5 (Navidrome Integration): Not started

**Overall MVP (Phase 1-3): 90% complete** 🎯

### Code Quality

```bash
flutter analyze
```

**Current Status**: ✅ 0 errors, ✅ 0 warnings, ℹ️ 56 info (style suggestions)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter/Dart style conventions
- Run `flutter analyze` before committing
- Add tests for new features
- Update documentation as needed
- Use conventional commit messages (`feat:`, `fix:`, `docs:`, etc.)

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

Built with these amazing open-source projects:

- [Flutter](https://flutter.dev) - UI framework
- [Riverpod](https://riverpod.dev) - State management
- [MediaKit](https://github.com/media-kit/media-kit) - Audio playback
- [Hive](https://github.com/hivedb/hive) - Lightweight database
- [metadata_god](https://github.com/creativecreatorormaybenot/metadata_god) - Metadata extraction
- [Phosphor Icons](https://phosphoricons.com) - Icon set
- [Navidrome](https://www.navidrome.org) - Future server integration

---

## 📞 Support & Feedback

- **Issues**: [GitHub Issues](https://github.com/iMMIQ/echo_music/issues)
- **Discussions**: [GitHub Discussions](https://github.com/iMMIQ/echo_music/discussions)

---

<div align="center">

**Made with ❤️ using Flutter**

[⬆ Back to Top](#echo-music)

</div>
