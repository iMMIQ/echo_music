# Echo Music - Development Guide

## Getting Started

### Prerequisites

1. **Flutter SDK** (3.27+)
   ```bash
   flutter --version
   ```

2. **Dart SDK** (3.10+)
   ```bash
   dart --version
   ```

3. **Platform-specific requirements**

   **Android:**
   - Android Studio
   - Android SDK (API 21+)

   **Windows:**
   - Visual Studio 2022 with C++ desktop development

   **Linux:**
   ```bash
   sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
   ```

### Initial Setup

1. **Clone the repository**
   ```bash
   cd echo_music
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
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

---

## Code Generation

This project uses **code generation** for:
- Riverpod providers (`@riverpod`)
- Freezed models (`@freezed`)
- JSON serialization (`@JsonSerializable`)
- Hive adapters (`@HiveType`)

### Running the Build Runner

Whenever you change:
- A model with `@freezed`
- A provider with `@riverpod`
- A class with JSON serialization
- A Hive model

Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous watching during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## Project Structure Overview

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── constants/
│   │   └── app_constants.dart        # App-wide constants
│   ├── theme/
│   │   └── app_theme.dart            # Theme configuration
│   ├── utils/                        # Utility functions
│   └── extensions/                   # Dart extensions
├── data/
│   ├── models/                       # Data models with Freezed
│   │   ├── song_model.dart
│   │   ├── album_model.dart
│   │   ├── artist_model.dart
│   │   └── playlist_model.dart
│   ├── repositories/                 # Repository implementations
│   └── services/                     # External services
│       ├── audio_service.dart
│       ├── library_service.dart
│       └── navidrome_service.dart
├── domain/
│   ├── entities/                     # Business entities
│   └── usecases/                     # Use cases
└── presentation/
    ├── providers/                    # Riverpod providers
    │   ├── playback_controller.dart
    │   ├── library_controller.dart
    │   └── settings_controller.dart
    ├── pages/                        # Full-screen pages
    │   ├── home_page.dart
    │   ├── player_page.dart
    │   └── settings_page.dart
    ├── widgets/                      # Reusable widgets
    │   ├── mini_player.dart
    │   ├── song_tile.dart
    │   └── album_card.dart
    └── dialogs/                      # Dialogs and bottom sheets
```

---

## Coding Conventions

### Dart/Flutter Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` before committing
- Run `dart analyze` to catch issues

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `lowerCamelCase` (private) or `UPPER_SNAKE_CASE` (public)
- **Providers**: `lowerCamelCase` + `Provider` suffix

### Example

```dart
// ✅ Good
@riverpod
class AudioController extends _$AudioController {
  @override
  AudioState build() => AudioState.initial();
}

// ❌ Bad
@riverpod
class audio_controller extends _$audio_controller {}
```

---

## State Management with Riverpod

### Provider Types

**1. StateNotifierProvider (for stateful logic)**
```dart
@riverpod
class PlaybackController extends _$PlaybackController {
  @override
  PlaybackState build() => PlaybackState.initial();

  Future<void> playSong(Song song) async {
    state = state.copyWith(isLoading: true);
    // Implementation
    state = state.copyWith(isLoading: false);
  }
}

// Usage
final controller = ref.watch(playbackControllerProvider);
controller.playSong(song);
```

**2. FutureProvider (for async data)**
```dart
@riverpod
Future<List<Song>> songs(Ref ref) async {
  final library = ref.watch(libraryServiceProvider);
  return library.getAllSongs();
}

// Usage
final songsAsync = ref.watch(songsProvider);
songsAsync.when(
  data: (songs) => SongList(songs: songs),
  loading: () => CircularProgressIndicator(),
  error: (e, s) => ErrorWidget(e),
);
```

**3. StreamProvider (for real-time data)**
```dart
@riverpod
Stream<Duration> playbackPosition(Ref ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.positionStream;
}
```

**4. ServiceProvider (for singletons)**
```dart
@riverpod
AudioService audioService(AudioServiceRef ref) {
  return AudioServiceImpl();
}
```

### Watching Providers

```dart
// In a ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playbackControllerProvider);
    return Text(state.currentSong?.title ?? 'No song');
  }
}

// In a ConsumerStatefulWidget
class MyPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(songsProvider);
    return ListView.builder(...);
  }
}
```

---

## Working with Hive

### Defining Models

```dart
import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'song_model.freezed.dart';
part 'song_model.g.dart';

@freezed
class Song with _$Song {
  const Song._();

  const factory Song({
    required String id,
    required String title,
    @HiveField(2) String? artist,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) =>
      _$SongFromJson(json);
}

// Custom adapter (optional)
class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) { /* ... */ }

  @override
  void write(BinaryWriter writer, Song obj) { /* ... */ }
}
```

### Using Hive

```dart
// Open a box
final songsBox = await Hive.openBox<Song>('songs');

// Add data
await songsBox.put('id', song);

// Read data
final song = songsBox.get('id');

// Query data
final allSongs = songsBox.values.toList();

// Delete data
await songsBox.delete('id');
```

---

## UI Guidelines

### Building Pages

All pages should be:
- Stateful widgets that inherit from `ConsumerStatefulWidget`
- Located in `lib/presentation/pages/`
- Named with `_page.dart` suffix

```dart
class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({super.key});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```

### Building Widgets

Reusable widgets should be:
- Stateless widgets inheriting from `ConsumerWidget`
- Located in `lib/presentation/widgets/`
- Named descriptively

```dart
class SongTile extends ConsumerWidget {
  const SongTile({
    required this.song,
    super.key,
  });

  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(...);
  }
}
```

### Using Theme

```dart
// Colors
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface

// Text styles
Theme.of(context).textTheme.headlineMedium
Theme.of(context).textTheme.bodyLarge

// Spacing
import 'package:echo_music/core/theme/app_theme.dart';
DesignTokens.spacing4  // 16.0
DesignTokens.radiusMedium  // 12.0
```

---

## Testing

### Unit Tests

```bash
flutter test test/unit/
```

### Widget Tests

```bash
flutter test test/widget/
```

### Integration Tests

```bash
flutter test integration_test/
```

---

## Build & Release

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

### Windows

```bash
flutter build windows --release
```

### Linux

```bash
flutter build linux --release
```

---

## Troubleshooting

### Build Runner Issues

**Problem**: Build runner fails with conflicts

**Solution**:
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Hive Issues

**Problem**: Hive adapter not found

**Solution**: Make sure to:
1. Annotate models with `@HiveType(typeId: x)`
2. Run `dart run build_runner build`
3. Register adapters before opening boxes

### Platform-Specific Issues

**Android**: Check `android/app/src/main/AndroidManifest.xml` for permissions

**Windows**: Ensure Visual Studio 2022 with C++ workload is installed

**Linux**: Install GTK3 development libraries

---

## Useful Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)
- [Hive Documentation](https://docs.hivedb.dev)
- [just_audio Package](https://pub.dev/packages/just_audio)
- [Phosphor Icons](https://phosphoricons.com)

---

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests and linting
4. Update documentation if needed
5. Submit a pull request

---

## Questions?

Check the documentation in the `docs/` folder:
- `ARCHITECTURE.md` - Architecture details
- `API_REFERENCE.md` - API documentation
- `UI_DESIGN.md` - UI/UX guidelines
- `ROADMAP.md` - Development roadmap
