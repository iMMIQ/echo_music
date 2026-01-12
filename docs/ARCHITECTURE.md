# Echo Music - Architecture Document

## Overview

Echo Music follows Clean Architecture principles with clear separation of concerns across three main layers:

1. **Presentation Layer** - UI and state management (Riverpod)
2. **Domain Layer** - Business logic and entities
3. **Data Layer** - Data models, repositories, and services

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (Pages, Widgets, Riverpod Providers)   │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│           Domain Layer                  │
│      (Entities, Use Cases)              │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│            Data Layer                   │
│  (Models, Repositories, Services)       │
└─────────────────────────────────────────┘
```

## Layer Responsibilities

### Presentation Layer (`lib/presentation/`)

**Responsibilities:**
- UI rendering and user interaction
- State management using Riverpod
- Navigation logic
- Input validation and transformation

**Components:**
- `providers/` - Riverpod providers (state management)
- `pages/` - Full-screen pages (routes)
- `widgets/` - Reusable UI components
- `dialogs/` - Dialogs, bottom sheets, modals

**Rules:**
- Never contains business logic
- Only communicates with Domain layer through use cases
- State changes trigger UI rebuilds

### Domain Layer (`lib/domain/`)

**Responsibilities:**
- Business logic and rules
- Use case implementations
- Entity definitions (core business objects)
- No dependencies on Flutter or external frameworks

**Components:**
- `entities/` - Core business entities (independent of data sources)
- `usecases/` - Single-responsibility use cases

**Rules:**
- Framework-agnostic (no Flutter dependencies)
- Depends only on abstractions (interfaces)
- Contains no data models (those are in Data layer)

### Data Layer (`lib/data/`)

**Responsibilities:**
- Data management and persistence
- External service communication
- Data transformation between models and entities

**Components:**
- `models/` - Data transfer objects (DTOs), Hive models
- `repositories/` - Repository implementations
- `services/` - External services (audio player, Navidrome API, file system)

**Rules:**
- Implements interfaces defined in Domain layer
- Handles all external dependencies
- Manages data caching and synchronization

## Core Components

### Audio Service

**Responsibilities:**
- Audio playback control (play, pause, seek, stop)
- Queue management
- Playback state management
- Audio focus handling

**Key Methods:**
```dart
// Playback control
play()
pause()
seek(Duration position)
stop()

// Queue management
addToQueue(Song song)
removeFromQueue(String songId)
clearQueue()
reorderQueue(int oldIndex, int newIndex)

// State
Stream<PlaybackState> playbackState
Stream<Duration> position
Stream<Duration> duration
```

### Media Library Service

**Responsibilities:**
- Scan local files for music
- Extract metadata (ID3 tags)
- Manage library database
- Handle album artwork

**Key Methods:**
```dart
Future<List<Song>> scanDirectory(String path)
Future<void> updateMetadata(Song song)
Future<AlbumArt?> extractAlbumArt(String filePath)
Future<List<Song>> search(String query)
```

### Navidrome Service (Future)

**Responsibilities:**
- Authenticate with Navidrome server
- Fetch library data
- Stream music from server
- Sync playback state

**Key Methods:**
```dart
Future<void> connect(String url, String username, String password)
Future<List<Song>> fetchLibrary()
Future<void> streamSong(String songId)
Future<void> syncFavorites()
```

## State Management Strategy

### Riverpod Architecture

We use Riverpod 2.x with code generation for type-safe, compile-time checked state management.

**Provider Types:**

1. **StateNotifierProvider** - For complex state with business logic
```dart
@riverpod
class PlaybackController extends _$PlaybackController {
  @override
  PlaybackState build() => PlaybackState.initial();

  Future<void> playSong(Song song) async {
    state = state.copyWith(isLoading: true);
    // Implementation
  }
}
```

2. **FutureProvider** - For async data fetching
```dart
@riverpod
Future<List<Song>> library(Ref ref) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.fetchLibrary();
}
```

3. **StreamProvider** - For real-time data streams
```dart
@riverpod
Stream<Duration> playbackPosition(Ref ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.positionStream;
}
```

4. **ServiceProvider** - For singleton services
```dart
@riverpod
AudioService audioService(AudioServiceRef ref) {
  return AudioService();
}
```

## Data Models

### Core Entities

**Song Entity:**
```dart
class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final Duration duration;
  final String filePath;
  final AlbumArt? albumArt;
  final int? trackNumber;
  final int? year;
  final String? genre;
}
```

**Playlist Entity:**
```dart
class Playlist {
  final String id;
  final String name;
  final List<Song> songs;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

**Album Entity:**
```dart
class Album {
  final String id;
  final String name;
  final String artist;
  final AlbumArt? artwork;
  final int? year;
  final List<Song> songs;
}
```

**Artist Entity:**
```dart
class Artist {
  final String id;
  final String name;
  final List<Album> albums;
  final AlbumArt? artwork;
}
```

### Database Schema (Hive)

**Boxes:**
- `songs` - All songs in library
- `playlists` - User playlists
- `albums` - Album metadata
- `artists` - Artist metadata
- `playback_history` - Recently played
- `favorites` - Favorite songs
- `settings` - App settings

**Indexes:**
- Song title (for search)
- Artist name (for grouping)
- Album name (for grouping)
- File path (unique identifier)

## Navigation Structure

```
Home (MainScreen)
├── Library (Songs, Albums, Artists)
├── Playlists
├── Now Playing
├── Search
└── Settings
    ├── Audio Settings
    ├── Equalizer
    ├── Appearance
    └── Navidrome Settings
```

## Error Handling Strategy

### Error Types

1. **Network Errors** - API failures
2. **File System Errors** - Missing files, permission issues
3. **Playback Errors** - Unsupported formats, codec issues
4. **Validation Errors** - Invalid user input

### Handling Approach

- Use `Result<T>` type for operations that can fail
- Display user-friendly error messages
- Log technical details for debugging
- Graceful degradation where possible

```dart
@riverpod
Future<Result<List<Song>>> scanLibrary(Ref ref) async {
  try {
    final songs = await ref.watch(libraryServiceProvider).scan();
    return Result.success(songs);
  } on FileSystemException catch (e) {
    return Result.failure('Failed to access files: ${e.message}');
  } catch (e) {
    return Result.failure('An unexpected error occurred');
  }
}
```

## Performance Optimization

### Strategies

1. **Lazy Loading** - Load data on demand
2. **Caching** - Cache frequently accessed data
3. **Pagination** - Paginate large lists
4. **Image Caching** - Use `cached_network_image`
5. **Debouncing** - Debounce search queries
6. **Efficient Rebuilds** - Use `select` in Riverpod to minimize rebuilds

### Memory Management

- Dispose controllers properly
- Close streams when not needed
- Use weak references where appropriate
- Limit image cache size

## Security Considerations

1. **Permissions** - Request only necessary permissions
2. **Credentials** - Securely store Navidrome credentials
3. **Data Privacy** - No telemetry without consent
4. **File Access** - Sandboxed file access where possible

## Testing Strategy

### Unit Tests
- Domain layer use cases
- Business logic
- Data transformations

### Widget Tests
- UI components
- User interactions
- State changes

### Integration Tests
- Full user flows
- Service integration
- End-to-end scenarios

## Future Enhancements

1. **Offline Mode** - Cache Navidrome content
2. **Chromecast Support** - Cast to external devices
3. **Lyrics Display** - Fetch and display lyrics
4. **Podcast Support** - Add podcast playback
5. **Smart Playlists** - Auto-generated playlists based on criteria
6. **Social Features** - Share playlists, discover friends' music
