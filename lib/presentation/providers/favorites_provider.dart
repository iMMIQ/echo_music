import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'library_provider.dart';

part 'favorites_provider.g.dart';

/// Favorites controller
@riverpod
class FavoritesController extends _$FavoritesController {
  @override
  FutureOr<void> build() {}

  /// Toggle favorite status for a song
  Future<void> toggleFavorite(String songId) async {
    state = await AsyncValue.guard(() async {
      final service = ref.read(libraryServiceProvider);
      await service.toggleFavorite(songId);
      // Invalidate the favorite songs provider to refresh the list
      ref.invalidate(favoriteSongsProvider);
    });
  }
}
