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
String _$libraryServiceHash() => r'71777da07e82ccc4eff7ee454f2d9e3b785002c1';

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
String _$allSongsHash() => r'ced01c986e9e2b76fd168e24ba4dac3b8fcc01f9';

/// All songs provider
///
/// Copied from [allSongs].
@ProviderFor(allSongs)
final allSongsProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  allSongs,
  name: r'allSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllSongsRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$favoriteSongsHash() => r'6b27fe15b58206fb83d8dab2ddc0f6bfb09e1579';

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
String _$recentlyPlayedHash() => r'674a6bf2c72d26d4c8a3e94cbcb2e67bc706a36f';

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
String _$libraryStatsHash() => r'e6c28063d4c0bf2fd53bc5c066769d524cfbfee7';

/// Library stats provider
///
/// Copied from [libraryStats].
@ProviderFor(libraryStats)
final libraryStatsProvider = AutoDisposeFutureProvider<LibraryStats>.internal(
  libraryStats,
  name: r'libraryStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$libraryStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryStatsRef = AutoDisposeFutureProviderRef<LibraryStats>;
String _$importControllerHash() => r'717deb945cc64be57df8288913b24369bbc6eb56';

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
