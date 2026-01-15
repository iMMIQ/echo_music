// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$metadataServiceHash() => r'cbcf1dd96db8700f1fafc3eb6ead61716da3a910';

/// Metadata service provider
///
/// Copied from [metadataService].
@ProviderFor(metadataService)
final metadataServiceProvider = AutoDisposeProvider<MetadataService>.internal(
  metadataService,
  name: r'metadataServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$metadataServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MetadataServiceRef = AutoDisposeProviderRef<MetadataService>;
String _$libraryServiceHash() => r'926bf43f5917f1f189a266f1e3224eba6fd99635';

/// Library service provider
///
/// Copied from [libraryService].
@ProviderFor(libraryService)
final libraryServiceProvider = AutoDisposeProvider<LibraryService>.internal(
  libraryService,
  name: r'libraryServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$libraryServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryServiceRef = AutoDisposeProviderRef<LibraryService>;
String _$allSongsHash() => r'bfeb07d66a3b7a521acc524ca0b5e1725d7af842';

/// All songs provider
///
/// Copied from [allSongs].
@ProviderFor(allSongs)
final allSongsProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  allSongs,
  name: r'allSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllSongsRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$favoriteSongsHash() => r'676bd19accb23576b6d4ee125653309e5dd44d08';

/// Favorite songs provider
///
/// Copied from [favoriteSongs].
@ProviderFor(favoriteSongs)
final favoriteSongsProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  favoriteSongs,
  name: r'favoriteSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteSongsRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$recentlyPlayedHash() => r'9e7d1aeb9aee596cb05ce74a988fe88291fb5125';

/// Recently played provider
///
/// Copied from [recentlyPlayed].
@ProviderFor(recentlyPlayed)
final recentlyPlayedProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  recentlyPlayed,
  name: r'recentlyPlayedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentlyPlayedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentlyPlayedRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$libraryStatsHash() => r'3a9ab6ee1bf6a877a0b5f2db9a77aa710b781d0a';

/// Library stats provider
///
/// Copied from [libraryStats].
@ProviderFor(libraryStats)
final libraryStatsProvider = AutoDisposeFutureProvider<LibraryStats>.internal(
  libraryStats,
  name: r'libraryStatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$libraryStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryStatsRef = AutoDisposeFutureProviderRef<LibraryStats>;
String _$allAlbumsHash() => r'c31547f0fb3a3386a2181f873801500ed1a7af64';

/// All albums provider
///
/// Copied from [allAlbums].
@ProviderFor(allAlbums)
final allAlbumsProvider = AutoDisposeFutureProvider<List<Album>>.internal(
  allAlbums,
  name: r'allAlbumsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allAlbumsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllAlbumsRef = AutoDisposeFutureProviderRef<List<Album>>;
String _$allArtistsHash() => r'94d5aafde6861b550df1079c91147576effdd22a';

/// All artists provider
///
/// Copied from [allArtists].
@ProviderFor(allArtists)
final allArtistsProvider = AutoDisposeFutureProvider<List<Artist>>.internal(
  allArtists,
  name: r'allArtistsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allArtistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllArtistsRef = AutoDisposeFutureProviderRef<List<Artist>>;
String _$importControllerHash() => r'909566891ad886e1ac8df36e45de4b391e08a2e6';

/// Import music controller
///
/// Copied from [ImportController].
@ProviderFor(ImportController)
final importControllerProvider =
    AutoDisposeAsyncNotifierProvider<ImportController, List<Song>>.internal(
  ImportController.new,
  name: r'importControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$importControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImportController = AutoDisposeAsyncNotifier<List<Song>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
