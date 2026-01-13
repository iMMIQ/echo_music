import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';

/// Library service interface for media library management
abstract class LibraryService {
  // === Song Management ===

  /// Get all songs
  Future<List<Song>> getAllSongs();

  /// Get song by ID
  Future<Song?> getSongById(String id);

  /// Search songs by query
  Future<List<Song>> searchSongs(String query);

  /// Get songs by artist
  Future<List<Song>> getSongsByArtist(String artistId);

  /// Get songs by album
  Future<List<Song>> getSongsByAlbum(String albumId);

  /// Get songs by genre
  Future<List<Song>> getSongsByGenre(String genre);

  /// Add song to library
  Future<void> addSong(Song song);

  /// Add multiple songs to library
  Future<void> addSongs(List<Song> songs);

  /// Remove song from library
  Future<void> removeSong(String songId);

  /// Update song
  Future<void> updateSong(Song song);

  /// Toggle favorite status
  Future<void> toggleFavorite(String songId);

  /// Get favorite songs
  Future<List<Song>> getFavoriteSongs();

  /// Increment play count
  Future<void> incrementPlayCount(String songId);

  /// Get recently played songs
  Future<List<Song>> getRecentlyPlayed({int limit = 20});

  // === Album Management ===

  /// Get all albums
  Future<List<Album>> getAllAlbums();

  /// Get album by ID
  Future<Album?> getAlbumById(String id);

  /// Get albums by artist
  Future<List<Album>> getAlbumsByArtist(String artistId);

  /// Search albums
  Future<List<Album>> searchAlbums(String query);

  /// Add album to library
  Future<void> addAlbum(Album album);

  /// Remove album from library
  Future<void> removeAlbum(String albumId);

  /// Update album
  Future<void> updateAlbum(Album album);

  // === Artist Management ===

  /// Get all artists
  Future<List<Artist>> getAllArtists();

  /// Get artist by ID
  Future<Artist?> getArtistById(String id);

  /// Search artists
  Future<List<Artist>> searchArtists(String query);

  /// Add artist to library
  Future<void> addArtist(Artist artist);

  /// Remove artist from library
  Future<void> removeArtist(String artistId);

  /// Update artist
  Future<void> updateArtist(Artist artist);

  // === Library Scanning ===

  /// Scan directory for music files
  Future<List<Song>> scanDirectory(String path);

  /// Scan multiple directories
  Future<List<Song>> scanDirectories(List<String> paths);

  /// Import files from picker
  Future<List<Song>> importFiles(List<String> filePaths);

  /// Pick audio files using file picker
  Future<List<String>> pickAudioFiles();

  /// Pick a directory for scanning
  Future<String?> pickDirectory();

  /// Get library statistics
  Future<LibraryStats> getStats();

  /// Clear entire library
  Future<void> clearLibrary();
}

/// Library statistics
class LibraryStats {
  const LibraryStats({
    required this.songCount,
    required this.albumCount,
    required this.artistCount,
    required this.playlistCount,
    required this.totalDuration,
    required this.favoriteCount,
  });
  final int songCount;
  final int albumCount;
  final int artistCount;
  final int playlistCount;
  final Duration totalDuration;
  final int favoriteCount;

  /// Empty stats
  static const empty = LibraryStats(
    songCount: 0,
    albumCount: 0,
    artistCount: 0,
    playlistCount: 0,
    totalDuration: Duration.zero,
    favoriteCount: 0,
  );
}
