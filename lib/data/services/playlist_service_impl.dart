import 'package:hive/hive.dart';

import '../models/playlist_model.dart';
import '../models/song_model.dart';
import 'library_service.dart';
import 'playlist_service.dart';

/// Playlist service implementation
class PlaylistServiceImpl extends PlaylistService {
  PlaylistServiceImpl(this._libraryService);
  final LibraryService _libraryService;
  late Box<Playlist> _playlistsBox;

  /// Initialize the service (must be called before use)
  Future<void> init() async {
    _playlistsBox = await Hive.openBox<Playlist>('playlists');
  }

  // === Playlist CRUD ===

  @override
  Future<List<Playlist>> getAllPlaylists() async {
    return _playlistsBox.values.toList();
  }

  @override
  Future<Playlist?> getPlaylistById(String id) async {
    return _playlistsBox.get(id);
  }

  @override
  Future<Playlist> createPlaylist({
    required String name,
    String? description,
    AlbumArt? artwork,
  }) async {
    final playlist = Playlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      artwork: artwork,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      songs: [],
      isSmartPlaylist: false,
    );
    await _playlistsBox.put(playlist.id, playlist);
    return playlist;
  }

  @override
  Future<void> updatePlaylist(Playlist playlist) async {
    final updated = playlist.copyWith(updatedAt: DateTime.now());
    await _playlistsBox.put(playlist.id, updated);
  }

  @override
  Future<void> deletePlaylist(String playlistId) async {
    await _playlistsBox.delete(playlistId);
  }

  // === Song Management ===

  @override
  Future<void> addSongToPlaylist(String playlistId, Song song) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return;

    // Check if song already exists
    if (playlist.songs.any((s) => s.id == song.id)) {
      return; // Song already in playlist
    }

    final updated = playlist.copyWith(
      songs: [...playlist.songs, song],
      updatedAt: DateTime.now(),
    );
    await _playlistsBox.put(playlistId, updated);
  }

  @override
  Future<void> addSongsToPlaylist(String playlistId, List<Song> songs) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return;

    // Filter out songs that already exist
    final existingIds = playlist.songs.map((s) => s.id).toSet();
    final newSongs = songs.where((s) => !existingIds.contains(s.id)).toList();

    final updated = playlist.copyWith(
      songs: [...playlist.songs, ...newSongs],
      updatedAt: DateTime.now(),
    );
    await _playlistsBox.put(playlistId, updated);
  }

  @override
  Future<void> removeSongFromPlaylist(String playlistId, String songId) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return;

    final updated = playlist.copyWith(
      songs: playlist.songs.where((s) => s.id != songId).toList(),
      updatedAt: DateTime.now(),
    );
    await _playlistsBox.put(playlistId, updated);
  }

  @override
  Future<void> removeSongAt(String playlistId, int index) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return;

    if (index < 0 || index >= playlist.songs.length) {
      return; // Invalid index
    }

    final updatedSongs = List<Song>.from(playlist.songs)..removeAt(index);
    final updated = playlist.copyWith(
      songs: updatedSongs,
      updatedAt: DateTime.now(),
    );
    await _playlistsBox.put(playlistId, updated);
  }

  @override
  Future<void> reorderSongs(String playlistId, int oldIndex, int newIndex) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return;

    if (oldIndex < 0 ||
        oldIndex >= playlist.songs.length ||
        newIndex < 0 ||
        newIndex >= playlist.songs.length) {
      return; // Invalid indices
    }

    final songs = List<Song>.from(playlist.songs);
    final item = songs.removeAt(oldIndex);
    songs.insert(newIndex, item);

    final updated = playlist.copyWith(
      songs: songs,
      updatedAt: DateTime.now(),
    );
    await _playlistsBox.put(playlistId, updated);
  }

  @override
  Future<List<Song>> getPlaylistSongs(String playlistId) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return [];
    return playlist.songs;
  }

  @override
  Future<bool> isSongInPlaylist(String playlistId, String songId) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null) return false;
    return playlist.songs.any((s) => s.id == songId);
  }

  // === Smart Playlists ===

  @override
  Future<Playlist> createSmartPlaylist({
    required String name,
    required String rules,
    String? description,
  }) async {
    final playlist = Playlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      songs: [], // Will be populated by evaluation
      isSmartPlaylist: true,
      smartPlaylistRules: rules,
    );
    await _playlistsBox.put(playlist.id, playlist);

    // Evaluate the playlist to populate initial songs
    final songs = await evaluateSmartPlaylist(playlist.id);
    final updated = playlist.copyWith(songs: songs);
    await _playlistsBox.put(playlist.id, updated);

    return updated;
  }

  @override
  Future<void> updateSmartPlaylistRules(String playlistId, String rules) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null || !playlist.isSmartPlaylist) return;

    final updated = playlist.copyWith(
      smartPlaylistRules: rules,
      updatedAt: DateTime.now(),
    );
    await _playlistsBox.put(playlistId, updated);

    // Re-evaluate the playlist
    final songs = await evaluateSmartPlaylist(playlistId);
    final finalPlaylist = updated.copyWith(songs: songs);
    await _playlistsBox.put(playlistId, finalPlaylist);
  }

  @override
  Future<List<Song>> evaluateSmartPlaylist(String playlistId) async {
    final playlist = await getPlaylistById(playlistId);
    if (playlist == null || !playlist.isSmartPlaylist) {
      return [];
    }

    final rules = playlist.smartPlaylistRules;
    if (rules == null || rules.isEmpty) {
      return [];
    }

    // Simple rule parsing: genre:rock, year:>2020, artist:Beatles
    final allSongs = await _libraryService.getAllSongs();
    final ruleConditions = rules.split(',');

    return allSongs.where((song) {
      return ruleConditions.every((condition) {
        final parts = condition.split(':');
        if (parts.length != 2) return true;

        final field = parts[0].trim().toLowerCase();
        final value = parts[1].trim().toLowerCase();

        switch (field) {
          case 'genre':
            final genre = song.genre ?? '';
            return genre.toLowerCase().contains(value);
          case 'year':
            final songYear = song.year ?? 0;
            if (value.startsWith('>')) {
              final parsedYear = int.tryParse(value.substring(1));
              return parsedYear != null && songYear > parsedYear;
            } else if (value.startsWith('<')) {
              final parsedYear = int.tryParse(value.substring(1));
              return parsedYear != null && songYear < parsedYear;
            } else {
              final parsedYear = int.tryParse(value);
              return parsedYear != null && songYear == parsedYear;
            }
          case 'artist':
            return song.artist.toLowerCase().contains(value);
          case 'album':
            return song.album.toLowerCase().contains(value);
          case 'favorite':
            final isFav = value == 'true';
            return song.isFavorite == isFav;
          default:
            return true;
        }
      });
    }).toList();
  }

  // === Favorites ===

  static const String _favoritesPlaylistId = 'favorites';

  @override
  Future<Playlist> getFavoritesPlaylist() async {
    // Get or create favorites playlist
    var favorites = await getPlaylistById(_favoritesPlaylistId);
    if (favorites == null) {
      favorites = Playlist(
        id: _favoritesPlaylistId,
        name: 'Liked Songs',
        description: 'Your favorite tracks',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        songs: [],
        isSmartPlaylist: false,
      );
      await _playlistsBox.put(_favoritesPlaylistId, favorites);
    }
    return favorites;
  }

  @override
  Future<void> addToFavorites(Song song) async {
    await addSongToPlaylist(_favoritesPlaylistId, song);

    // Also mark song as favorite in library
    final favoriteSongs = await _libraryService.getFavoriteSongs();
    final isFavorite = favoriteSongs.any((s) => s.id == song.id);
    if (!isFavorite) {
      await _libraryService.toggleFavorite(song.id);
    }
  }

  @override
  Future<void> removeFromFavorites(String songId) async {
    await removeSongFromPlaylist(_favoritesPlaylistId, songId);

    // Also unmark song as favorite in library
    final favoriteSongs = await _libraryService.getFavoriteSongs();
    final isFavorite = favoriteSongs.any((s) => s.id == songId);
    if (isFavorite) {
      await _libraryService.toggleFavorite(songId);
    }
  }

  @override
  Future<bool> isFavorite(String songId) async {
    return await isSongInPlaylist(_favoritesPlaylistId, songId);
  }
}
