import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/playlist_model.dart';
import '../../data/models/song_model.dart';
import '../../data/services/playlist_service.dart';
import '../../data/services/playlist_service_impl.dart';
import 'library_provider.dart'
    show
        libraryServiceProvider,
        favoriteSongsProvider;

part 'playlist_provider.g.dart';

/// Playlist service provider
@riverpod
PlaylistService playlistService(PlaylistServiceRef ref) {
  final libraryService = ref.watch(libraryServiceProvider);
  final service = PlaylistServiceImpl(libraryService);

  // Initialize the service when first accessed
  unawaited(service.init());
  ref.onDispose(() {
    // Cleanup if needed
  });

  return service;
}

/// All playlists provider
@riverpod
Future<List<Playlist>> allPlaylists(AllPlaylistsRef ref) async {
  final service = ref.watch(playlistServiceProvider);
  // Ensure service is initialized
  if (service is PlaylistServiceImpl) {
    await service.init();
  }
  return service.getAllPlaylists();
}

/// Playlist by ID provider
@riverpod
Future<Playlist?> playlistById(
  PlaylistByIdRef ref,
  String id,
) async {
  final service = ref.watch(playlistServiceProvider);
  return service.getPlaylistById(id);
}

/// Playlist songs provider
@riverpod
Future<List<Song>> playlistSongs(
  PlaylistSongsRef ref,
  String playlistId,
) async {
  final service = ref.watch(playlistServiceProvider);
  return service.getPlaylistSongs(playlistId);
}

/// Favorites playlist provider
@riverpod
Future<Playlist> favoritesPlaylist(FavoritesPlaylistRef ref) async {
  final service = ref.watch(playlistServiceProvider);
  return service.getFavoritesPlaylist();
}

/// Is song favorite provider
@riverpod
Future<bool> isSongFavorite(
  IsSongFavoriteRef ref,
  String songId,
) async {
  final service = ref.watch(playlistServiceProvider);
  return service.isFavorite(songId);
}

/// Playlist controller
@riverpod
class PlaylistController extends _$PlaylistController {
  @override
  FutureOr<void> build() {}

  /// Create a new playlist
  Future<Playlist> createPlaylist({
    required String name,
    String? description,
  }) async {
    final service = ref.read(playlistServiceProvider);
    final playlist = await service.createPlaylist(
      name: name,
      description: description,
    );

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);

    return playlist;
  }

  /// Update a playlist
  Future<void> updatePlaylist(Playlist playlist) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.updatePlaylist(playlist);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
    ref.invalidate(playlistByIdProvider(playlist.id));
  }

  /// Delete a playlist
  Future<void> deletePlaylist(String playlistId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.deletePlaylist(playlistId);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
  }

  /// Add song to playlist
  Future<void> addSongToPlaylist(String playlistId, Song song) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.addSongToPlaylist(playlistId, song);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
    ref.invalidate(playlistByIdProvider(playlistId));
    ref.invalidate(playlistSongsProvider(playlistId));
  }

  /// Add multiple songs to playlist
  Future<void> addSongsToPlaylist(
    String playlistId,
    List<Song> songs,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.addSongsToPlaylist(playlistId, songs);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
    ref.invalidate(playlistByIdProvider(playlistId));
    ref.invalidate(playlistSongsProvider(playlistId));
  }

  /// Remove song from playlist
  Future<void> removeSongFromPlaylist(
    String playlistId,
    String songId,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.removeSongFromPlaylist(playlistId, songId);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
    ref.invalidate(playlistByIdProvider(playlistId));
    ref.invalidate(playlistSongsProvider(playlistId));
  }

  /// Remove song at position
  Future<void> removeSongAt(String playlistId, int index) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.removeSongAt(playlistId, index);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
    ref.invalidate(playlistByIdProvider(playlistId));
    ref.invalidate(playlistSongsProvider(playlistId));
  }

  /// Reorder songs in playlist
  Future<void> reorderSongs(
    String playlistId,
    int oldIndex,
    int newIndex,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      return service.reorderSongs(playlistId, oldIndex, newIndex);
    });

    // Invalidate providers to refresh
    ref.invalidate(allPlaylistsProvider);
    ref.invalidate(playlistByIdProvider(playlistId));
    ref.invalidate(playlistSongsProvider(playlistId));
  }
}

/// Favorites controller
@riverpod
class FavoritesController extends _$FavoritesController {
  @override
  FutureOr<void> build() {}

  /// Toggle favorite status
  Future<void> toggleFavorite(String songId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(playlistServiceProvider);
      final isFavorite = await service.isFavorite(songId);

      if (isFavorite) {
        await service.removeFromFavorites(songId);
      } else {
        // We need the song object, but we only have the ID
        // Get the song from library service
        final libraryService = ref.read(libraryServiceProvider);
        final song = await libraryService.getSongById(songId);
        if (song != null) {
          await service.addToFavorites(song);
        }
      }
    });

    // Invalidate providers to refresh
    ref.invalidate(favoritesPlaylistProvider);
    ref.invalidate(isSongFavoriteProvider(songId));
    ref.invalidate(favoriteSongsProvider);
  }
}
