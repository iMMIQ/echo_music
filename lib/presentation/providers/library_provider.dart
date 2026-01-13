import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/services/library_service.dart';
import '../../data/services/library_service_impl.dart';
import '../../data/services/metadata_service.dart';
import '../../data/services/metadata_service_impl.dart';
import '../../data/models/song_model.dart';

part 'library_provider.g.dart';

/// Metadata service provider
@riverpod
MetadataService metadataService(MetadataServiceRef ref) {
  return MetadataServiceImpl();
}

/// Library service provider
@riverpod
LibraryService libraryService(LibraryServiceRef ref) {
  final metadataService = ref.watch(metadataServiceProvider);
  final service = LibraryServiceImpl(metadataService);

  // Initialize the service when first accessed
  final future = service.init();
  ref.onDispose(() {
    // Cleanup if needed
  });

  // Return the service (it will be initialized async)
  return service;
}

/// All songs provider
@riverpod
Future<List<Song>> allSongs(AllSongsRef ref) async {
  final service = ref.watch(libraryServiceProvider);
  // Ensure service is initialized
  if (service is LibraryServiceImpl) {
    await (service as LibraryServiceImpl).init();
  }
  return await service.getAllSongs();
}

/// Favorite songs provider
@riverpod
Future<List<Song>> favoriteSongs(FavoriteSongsRef ref) async {
  final service = ref.watch(libraryServiceProvider);
  return await service.getFavoriteSongs();
}

/// Recently played provider
@riverpod
Future<List<Song>> recentlyPlayed(RecentlyPlayedRef ref) async {
  final service = ref.watch(libraryServiceProvider);
  return await service.getRecentlyPlayed();
}

/// Library stats provider
@riverpod
Future<LibraryStats> libraryStats(LibraryStatsRef ref) async {
  final service = ref.watch(libraryServiceProvider);
  return await service.getStats();
}

/// Import music controller
@riverpod
class ImportController extends _$ImportController {
  @override
  FutureOr<List<Song>> build() => [];

  /// Import audio files using file picker
  Future<List<Song>> importFiles() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(libraryServiceProvider);
      // Ensure service is initialized
      if (service is LibraryServiceImpl) {
        await (service as LibraryServiceImpl).init();
      }
      final filePaths = await service.pickAudioFiles();

      if (filePaths.isEmpty) {
        return [];
      }

      return await service.importFiles(filePaths);
    });

    // Invalidate the allSongsProvider to refresh the list
    ref.invalidate(allSongsProvider);

    return state.value ?? [];
  }

  /// Scan a directory for music
  Future<List<Song>> scanDirectory(String path) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(libraryServiceProvider);
      return await service.scanDirectory(path);
    });

    return state.value ?? [];
  }
}
