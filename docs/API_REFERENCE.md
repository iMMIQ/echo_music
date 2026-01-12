# Echo Music - API Reference

## Table of Contents

1. [Audio Service API](#audio-service-api)
2. [Library Service API](#library-service-api)
3. [Playlist Service API](#playlist-service-api)
4. [Navidrome Service API](#navidrome-service-api)
5. [Provider API](#provider-api)

---

## Audio Service API

### Overview

Manages all audio playback operations using `just_audio` and `audio_service`.

### Core Interface

```dart
abstract class AudioService {
  // Streams
  Stream<PlaybackState> get playbackState;
  Stream<Duration> get position;
  Stream<Duration> get bufferedPosition;
  Stream<Duration?> get duration;
  Stream<List<MediaItem>> get queue;
  Stream<int?> get currentIndex;

  // State getters
  bool get isPlaying;
  bool get isLoading;
  List<Song> get currentQueue;
  Song? get currentSong;

  // Playback controls
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);

  // Queue management
  Future<void> setSongList(List<Song> songs, {int startIndex = 0});
  Future<void> playSong(Song song);
  Future<void> playFromList(List<Song> songs, int index);
  Future<void> addToQueue(Song song);
  Future<void> removeFromQueue(int index);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> clearQueue();
  Future<void> shuffle();
  Future<void> setRepeatMode(RepeatMode mode);

  // Playback modes
  Future<void> setShuffleMode(ShuffleMode mode);
  Future<void> setSpeed(double speed);

  // Volume
  Future<void> setVolume(double volume);
  Future<void> setEqualizerEnabled(bool enabled);
  Future<void> setEqualizerPreset(String presetId);

  // Disposal
  Future<void> dispose();
}
```

### Enums

```dart
enum RepeatMode {
  off,
  all,
  one,
}

enum ShuffleMode {
  off,
  all,
}

enum PlaybackState {
  stopped,
  loading,
  playing,
  paused,
  buffering,
  error,
}
```

### Events

```dart
// Playback events
class PlayEvent {}
class PauseEvent {}
class StopEvent {}
class SeekEvent { final Duration position; }
class NextEvent {}
class PreviousEvent {}
class ShuffleEvent {}
class RepeatEvent { final RepeatMode mode; }

// Queue events
class AddToQueueEvent { final Song song; }
class RemoveFromQueueEvent { final int index; }
class ReorderQueueEvent { final int oldIndex; final int newIndex; }
```

---

## Library Service API

### Overview

Handles local music library scanning, metadata extraction, and library management.

### Core Interface

```dart
abstract class LibraryService {
  // Streams
  Stream<List<Song>> get songs;
  Stream<List<Album>> get albums;
  Stream<List<Artist>> get artists;
  Stream<double> get scanProgress;

  // State
  bool get isScanning;
  int get songCount;

  // Scanning
  Future<void> scanDirectories(List<String> paths);
  Future<void> scanSingleFile(String path);
  Future<void> stopScan();
  Future<void> refreshMetadata(List<Song> songs);

  // Retrieval
  Future<Song?> getSongById(String id);
  Future<List<Song>> getSongsByAlbum(String albumId);
  Future<List<Song>> getSongsByArtist(String artistId);
  Future<Album?> getAlbumById(String id);
  Future<Artist?> getArtistById(String id);

  // Search
  Future<List<Song>> searchSongs(String query);
  Future<List<Album>> searchAlbums(String query);
  Future<List<Artist>> searchArtists(String query);

  // Favorites
  Future<void> toggleFavorite(String songId);
  Future<bool> isFavorite(String songId);
  Future<List<Song>> getFavorites();

  // Recently played
  Future<void> addToHistory(Song song);
  Future<List<Song>> getRecentlyPlayed({int limit = 20});

  // Library management
  Future<void> removeFromLibrary(String songId);
  Future<void> clearLibrary();
  Future<void> exportLibrary(String outputPath);
  Future<void> importLibrary(String inputPath);
}
```

### Metadata Extraction

```dart
abstract class MetadataExtractor {
  Future<SongMetadata> extract(String filePath);
  Future<AlbumArt?> extractAlbumArt(String filePath);
  Future<Lyrics?> extractLyrics(String filePath);
}

class SongMetadata {
  final String title;
  final String artist;
  final String album;
  final int? year;
  final int? trackNumber;
  final int? discNumber;
  final String? genre;
  final AlbumArt? albumArt;
  final Duration duration;
  final int bitrate;
  final String format; // mp3, flac, etc.
}

class AlbumArt {
  final Uint8List data;
  final int width;
  final int height;
  final String mimeType;
}

class Lyrics {
  final String text;
  final bool isSynced; // true for LRC files
  final Map<Duration, String>? syncedLyrics;
}
```

---

## Playlist Service API

### Overview

Manages user-created playlists.

### Core Interface

```dart
abstract class PlaylistService {
  // Streams
  Stream<List<Playlist>> get playlists;

  // CRUD
  Future<Playlist> createPlaylist(String name, {List<Song> songs = const []});
  Future<void> deletePlaylist(String id);
  Future<void> renamePlaylist(String id, String newName);

  // Content management
  Future<void> addSongsToPlaylist(String playlistId, List<Song> songs);
  Future<void> removeSongFromPlaylist(String playlistId, int index);
  Future<void> moveSongInPlaylist(String playlistId, int oldIndex, int newIndex);
  Future<void> clearPlaylist(String id);

  // Retrieval
  Future<Playlist?> getPlaylistById(String id);
  Future<List<Song>> getPlaylistSongs(String id);

  // Special playlists
  Future<Playlist> getMostPlayed();
  Future<Playlist> getRecentlyAdded({int days = 30});
}
```

### Playlist Model

```dart
class Playlist {
  final String id;
  final String name;
  final String? description;
  final List<Song> songs;
  final AlbumArt? artwork;
  final int trackCount;
  final Duration totalDuration;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Auto-generated playlists
  final bool isSmartPlaylist;
  final String? smartPlaylistRules;
}
```

---

## Navidrome Service API

### Overview

Handles communication with Navidrome music servers.

### Core Interface

```dart
abstract class NavidromeService {
  // Connection
  Future<void> connect(String url, String username, String password);
  Future<void> disconnect();
  Stream<ConnectionState> get connectionState;

  // Authentication
  Future<String> authenticate(String username, String password);
  Future<void> refreshToken();
  Future<void> logout();

  // Library
  Future<List<Song>> fetchLibrary({int limit = 500, int offset = 0});
  Future<List<Album>> fetchAlbums({String artistId});
  Future<List<Artist>> fetchArtists();
  Future<List<Playlist>> fetchPlaylists();

  // Search
  Future<SearchResult> search(String query);

  // Streaming
  Future<String> getStreamUrl(String songId);
  Future<void> downloadSong(String songId, String destination);

  // Synchronization
  Future<void> syncLibrary();
  Future<void> syncFavorites();
  Future<void> syncPlaylists();

  // Scrobbling
  Future<void> scrobble(Song song);
  Future<void> nowPlaying(Song song);

  // Server info
  Future<ServerInfo> getServerInfo();
}
```

### Models

```dart
class SearchResult {
  final List<Song> songs;
  final List<Album> albums;
  final List<Artist> artists;
}

class ServerInfo {
  final String version;
  final String? apiVersion;
  final bool isScrobblingEnabled;
  final List<String> supportedFormats;
}

enum ConnectionState {
  disconnected,
  connecting,
  connected,
  error,
}
```

---

## Provider API

### Overview

Riverpod providers for state management throughout the app.

### Audio Providers

```dart
// Playback state
@riverpod
class PlaybackController extends _$PlaybackController {
  @override
  PlaybackState build() => PlaybackState.initial();

  Future<void> playSong(Song song) async { }
  Future<void> play() async { }
  Future<void> pause() async { }
  Future<void> seek(Duration position) async { }
  Future<void> next() async { }
  Future<void> previous() async { }
  Future<void> shuffle() async { }
  Future<void> setRepeatMode(RepeatMode mode) async { }
}

// Current song
@riverpod
Song? currentSong(CurrentSongRef ref) {
  final controller = ref.watch(playbackControllerProvider);
  return controller.currentSong;
}

// Playback position
@riverpod
Stream<Duration> playbackPosition(PlaybackPositionRef ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.position;
}

// Queue
@riverpod
class QueueController extends _$QueueController {
  @override
  List<Song> build() => [];

  Future<void> addSong(Song song) async { }
  Future<void> removeSong(int index) async { }
  Future<void> reorder(int oldIndex, int newIndex) async { }
  Future<void> clear() async { }
}
```

### Library Providers

```dart
// All songs
@riverpod
Future<List<Song>> songs(Ref ref) async {
  final library = ref.watch(libraryServiceProvider);
  return library.songs.first;
}

// All albums
@riverpod
Future<List<Album>> albums(Ref ref) async {
  final library = ref.watch(libraryServiceProvider);
  return library.albums.first;
}

// All artists
@riverpod
Future<List<Artist>> artists(Ref ref) async {
  final library = ref.watch(libraryServiceProvider);
  return library.artists.first;
}

// Favorites
@riverpod
Future<List<Song>> favorites(Ref ref) async {
  final library = ref.watch(libraryServiceProvider);
  return library.getFavorites();
}

// Recently played
@riverpod
Future<List<Song>> recentlyPlayed(Ref ref) async {
  final library = ref.watch(libraryServiceProvider);
  return library.getRecentlyPlayed();
}

// Search
@riverpod
class SearchController extends _$SearchController {
  @override
  SearchResult build() => SearchResult.empty();

  Future<void> search(String query) async { }
  void clear() { }
}
```

### Settings Providers

```dart
// App settings
@riverpod
class SettingsController extends _$SettingsController {
  @override
  AppSettings build() => AppSettings.defaultSettings();

  Future<void> updateTheme(ThemeMode mode) async { }
  Future<void> updateEqualizerPreset(String preset) async { }
  Future<void> updateScanDirectories(List<String> paths) async { }
  Future<void> setNavidromeServer(NavidromeConfig? config) async { }
}

class AppSettings {
  final ThemeMode themeMode;
  final String equalizerPreset;
  final List<String> scanDirectories;
  final bool autoScan;
  final bool gaplessPlayback;
  final double crossfadeDuration;
  final NavidromeConfig? navidromeConfig;
}
```

### Service Providers

```dart
// Audio service singleton
@riverpod
AudioService audioService(AudioServiceRef ref) {
  final service = AudioServiceImpl();
  ref.onDispose(() => service.dispose());
  return service;
}

// Library service singleton
@riverpod
LibraryService libraryService(LibraryServiceRef ref) {
  return LibraryServiceImpl();
}

// Playlist service singleton
@riverpod
PlaylistService playlistService(PlaylistServiceRef ref) {
  return PlaylistServiceImpl();
}

// Navidrome service singleton
@riverpod
NavidromeService navidromeService(NavidromeServiceRef ref) {
  return NavidromeServiceImpl();
}
```

---

## Common Data Types

### Song

```dart
class Song {
  final String id;                    // Unique identifier
  final String title;
  final String artist;
  final String album;
  final Duration duration;
  final String filePath;
  final AlbumArt? albumArt;
  final int? trackNumber;
  final int? discNumber;
  final int? year;
  final String? genre;
  final int bitrate;
  final String format;
  final bool isFavorite;
  final int playCount;
  final DateTime? lastPlayed;
}
```

### Album

```dart
class Album {
  final String id;
  final String name;
  final String artist;
  final String artistId;
  final AlbumArt? artwork;
  final int? year;
  final String? genre;
  final List<Song> songs;
  final int songCount;
  final Duration totalDuration;
}
```

### Artist

```dart
class Artist {
  final String id;
  final String name;
  final AlbumArt? artwork;
  final List<Album> albums;
  final int albumCount;
  final int songCount;
}
```

---

## Error Handling

### Error Types

```dart
abstract class AppException implements Exception {
  final String message;
  final dynamic cause;

  AppException(this.message, [this.cause]);

  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message, [super.cause]);
}

class FileSystemException extends AppException {
  FileSystemException(super.message, [super.cause]);
}

class PlaybackException extends AppException {
  PlaybackException(super.message, [super.cause]);
}

class AuthenticationException extends AppException {
  AuthenticationException(super.message, [super.cause]);
}

class ValidationException extends AppException {
  ValidationException(super.message, [super.cause]);
}
```

### Result Type

```dart
@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(AppException error) = Failure<T>;
}

// Usage
final result = await libraryService.scanLibrary();
result.when(
  success: (songs) => print('Found ${songs.length} songs'),
  failure: (error) => print('Error: $error'),
);
```

---

## Platform Channels

### Android

```kotlin
// AudioFocus
interface AudioFocusListener {
    fun onAudioFocusGained()
    fun onAudioFocusLost()
    fun onAudioFocusLostTransient()
    fun onAudioFocusLostTransientCanDuck()
}

// MediaSession
interface MediaSessionListener {
    fun onPlay()
    fun onPause()
    fun onSkipToNext()
    fun onSkipToPrevious()
    fun onSeekTo(position: Long)
    fun onSetShuffleMode(mode: Int)
    fun onSetRepeatMode(mode: Int)
}
```

### Windows

```cpp
// Media Transport Controls
interface MediaTransportControls {
    void play();
    void pause();
    void stop();
    void seek(long long position);
    void setVolume(double volume);
};
```

---

## Future API Enhancements

1. **Podcast Support** - New service for podcast management
2. **Radio Streaming** - Internet radio integration
3. **Lyrics Service** - Fetch and display synced lyrics
4. **Social Features** - Share playlists, discover friends
5. **Cloud Backup** - Backup library to cloud storage
