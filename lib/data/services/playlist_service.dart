import '../models/playlist_model.dart';
import '../models/song_model.dart';

/// Playlist service interface for playlist management
abstract class PlaylistService {
  // === Playlist CRUD ===

  /// Get all playlists
  Future<List<Playlist>> getAllPlaylists();

  /// Get playlist by ID
  Future<Playlist?> getPlaylistById(String id);

  /// Create new playlist
  Future<Playlist> createPlaylist({
    required String name,
    String? description,
    AlbumArt? artwork,
  });

  /// Update playlist
  Future<void> updatePlaylist(Playlist playlist);

  /// Delete playlist
  Future<void> deletePlaylist(String playlistId);

  // === Song Management ===

  /// Add song to playlist
  Future<void> addSongToPlaylist(String playlistId, Song song);

  /// Add multiple songs to playlist
  Future<void> addSongsToPlaylist(String playlistId, List<Song> songs);

  /// Remove song from playlist
  Future<void> removeSongFromPlaylist(String playlistId, String songId);

  /// Remove song at position
  Future<void> removeSongAt(String playlistId, int index);

  /// Reorder songs in playlist
  Future<void> reorderSongs(
    String playlistId,
    int oldIndex,
    int newIndex,
  );

  /// Get songs from playlist
  Future<List<Song>> getPlaylistSongs(String playlistId);

  /// Check if song is in playlist
  Future<bool> isSongInPlaylist(String playlistId, String songId);

  // === Smart Playlists ===

  /// Create smart playlist with rules
  Future<Playlist> createSmartPlaylist({
    required String name,
    required String rules,
    String? description,
  });

  /// Update smart playlist rules
  Future<void> updateSmartPlaylistRules(
    String playlistId,
    String rules,
  );

  /// Evaluate smart playlist (generate songs from rules)
  Future<List<Song>> evaluateSmartPlaylist(String playlistId);

  // === Favorites ===

  /// Get favorites playlist
  Future<Playlist> getFavoritesPlaylist();

  /// Add to favorites
  Future<void> addToFavorites(Song song);

  /// Remove from favorites
  Future<void> removeFromFavorites(String songId);

  /// Check if song is favorite
  Future<bool> isFavorite(String songId);
}
