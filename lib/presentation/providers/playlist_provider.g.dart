// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playlistServiceHash() => r'408ec5f6aa5e0521172f192e66d0ff8e03baa6f2';

/// Playlist service provider
///
/// Copied from [playlistService].
@ProviderFor(playlistService)
final playlistServiceProvider = AutoDisposeProvider<PlaylistService>.internal(
  playlistService,
  name: r'playlistServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playlistServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlaylistServiceRef = AutoDisposeProviderRef<PlaylistService>;
String _$allPlaylistsHash() => r'd578446d1cc8501039d2d6bb547564e9cd4bffb4';

/// All playlists provider
///
/// Copied from [allPlaylists].
@ProviderFor(allPlaylists)
final allPlaylistsProvider = AutoDisposeFutureProvider<List<Playlist>>.internal(
  allPlaylists,
  name: r'allPlaylistsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPlaylistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllPlaylistsRef = AutoDisposeFutureProviderRef<List<Playlist>>;
String _$playlistByIdHash() => r'e8d44979d5dda5b0e2c4cd36d1949aeb40ec9a16';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Playlist by ID provider
///
/// Copied from [playlistById].
@ProviderFor(playlistById)
const playlistByIdProvider = PlaylistByIdFamily();

/// Playlist by ID provider
///
/// Copied from [playlistById].
class PlaylistByIdFamily extends Family<AsyncValue<Playlist?>> {
  /// Playlist by ID provider
  ///
  /// Copied from [playlistById].
  const PlaylistByIdFamily();

  /// Playlist by ID provider
  ///
  /// Copied from [playlistById].
  PlaylistByIdProvider call(
    String id,
  ) {
    return PlaylistByIdProvider(
      id,
    );
  }

  @override
  PlaylistByIdProvider getProviderOverride(
    covariant PlaylistByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'playlistByIdProvider';
}

/// Playlist by ID provider
///
/// Copied from [playlistById].
class PlaylistByIdProvider extends AutoDisposeFutureProvider<Playlist?> {
  /// Playlist by ID provider
  ///
  /// Copied from [playlistById].
  PlaylistByIdProvider(
    String id,
  ) : this._internal(
          (ref) => playlistById(
            ref as PlaylistByIdRef,
            id,
          ),
          from: playlistByIdProvider,
          name: r'playlistByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playlistByIdHash,
          dependencies: PlaylistByIdFamily._dependencies,
          allTransitiveDependencies:
              PlaylistByIdFamily._allTransitiveDependencies,
          id: id,
        );

  PlaylistByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Playlist?> Function(PlaylistByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlaylistByIdProvider._internal(
        (ref) => create(ref as PlaylistByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Playlist?> createElement() {
    return _PlaylistByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlaylistByIdRef on AutoDisposeFutureProviderRef<Playlist?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PlaylistByIdProviderElement
    extends AutoDisposeFutureProviderElement<Playlist?> with PlaylistByIdRef {
  _PlaylistByIdProviderElement(super.provider);

  @override
  String get id => (origin as PlaylistByIdProvider).id;
}

String _$playlistSongsHash() => r'ac10cc76fed935ad2d1c66689d97e057dbb3b674';

/// Playlist songs provider
///
/// Copied from [playlistSongs].
@ProviderFor(playlistSongs)
const playlistSongsProvider = PlaylistSongsFamily();

/// Playlist songs provider
///
/// Copied from [playlistSongs].
class PlaylistSongsFamily extends Family<AsyncValue<List<Song>>> {
  /// Playlist songs provider
  ///
  /// Copied from [playlistSongs].
  const PlaylistSongsFamily();

  /// Playlist songs provider
  ///
  /// Copied from [playlistSongs].
  PlaylistSongsProvider call(
    String playlistId,
  ) {
    return PlaylistSongsProvider(
      playlistId,
    );
  }

  @override
  PlaylistSongsProvider getProviderOverride(
    covariant PlaylistSongsProvider provider,
  ) {
    return call(
      provider.playlistId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'playlistSongsProvider';
}

/// Playlist songs provider
///
/// Copied from [playlistSongs].
class PlaylistSongsProvider extends AutoDisposeFutureProvider<List<Song>> {
  /// Playlist songs provider
  ///
  /// Copied from [playlistSongs].
  PlaylistSongsProvider(
    String playlistId,
  ) : this._internal(
          (ref) => playlistSongs(
            ref as PlaylistSongsRef,
            playlistId,
          ),
          from: playlistSongsProvider,
          name: r'playlistSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playlistSongsHash,
          dependencies: PlaylistSongsFamily._dependencies,
          allTransitiveDependencies:
              PlaylistSongsFamily._allTransitiveDependencies,
          playlistId: playlistId,
        );

  PlaylistSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playlistId,
  }) : super.internal();

  final String playlistId;

  @override
  Override overrideWith(
    FutureOr<List<Song>> Function(PlaylistSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlaylistSongsProvider._internal(
        (ref) => create(ref as PlaylistSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playlistId: playlistId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _PlaylistSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistSongsProvider && other.playlistId == playlistId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playlistId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlaylistSongsRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `playlistId` of this provider.
  String get playlistId;
}

class _PlaylistSongsProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>> with PlaylistSongsRef {
  _PlaylistSongsProviderElement(super.provider);

  @override
  String get playlistId => (origin as PlaylistSongsProvider).playlistId;
}

String _$favoritesPlaylistHash() => r'5e84bfefd55f61ce6367c7dcaff2a67dab869974';

/// Favorites playlist provider
///
/// Copied from [favoritesPlaylist].
@ProviderFor(favoritesPlaylist)
final favoritesPlaylistProvider = AutoDisposeFutureProvider<Playlist>.internal(
  favoritesPlaylist,
  name: r'favoritesPlaylistProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesPlaylistHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesPlaylistRef = AutoDisposeFutureProviderRef<Playlist>;
String _$isSongFavoriteHash() => r'6668c317485257e9a0faf01fb28ed467ab69ac76';

/// Is song favorite provider
///
/// Copied from [isSongFavorite].
@ProviderFor(isSongFavorite)
const isSongFavoriteProvider = IsSongFavoriteFamily();

/// Is song favorite provider
///
/// Copied from [isSongFavorite].
class IsSongFavoriteFamily extends Family<AsyncValue<bool>> {
  /// Is song favorite provider
  ///
  /// Copied from [isSongFavorite].
  const IsSongFavoriteFamily();

  /// Is song favorite provider
  ///
  /// Copied from [isSongFavorite].
  IsSongFavoriteProvider call(
    String songId,
  ) {
    return IsSongFavoriteProvider(
      songId,
    );
  }

  @override
  IsSongFavoriteProvider getProviderOverride(
    covariant IsSongFavoriteProvider provider,
  ) {
    return call(
      provider.songId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isSongFavoriteProvider';
}

/// Is song favorite provider
///
/// Copied from [isSongFavorite].
class IsSongFavoriteProvider extends AutoDisposeFutureProvider<bool> {
  /// Is song favorite provider
  ///
  /// Copied from [isSongFavorite].
  IsSongFavoriteProvider(
    String songId,
  ) : this._internal(
          (ref) => isSongFavorite(
            ref as IsSongFavoriteRef,
            songId,
          ),
          from: isSongFavoriteProvider,
          name: r'isSongFavoriteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isSongFavoriteHash,
          dependencies: IsSongFavoriteFamily._dependencies,
          allTransitiveDependencies:
              IsSongFavoriteFamily._allTransitiveDependencies,
          songId: songId,
        );

  IsSongFavoriteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.songId,
  }) : super.internal();

  final String songId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsSongFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsSongFavoriteProvider._internal(
        (ref) => create(ref as IsSongFavoriteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        songId: songId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsSongFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsSongFavoriteProvider && other.songId == songId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, songId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsSongFavoriteRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `songId` of this provider.
  String get songId;
}

class _IsSongFavoriteProviderElement
    extends AutoDisposeFutureProviderElement<bool> with IsSongFavoriteRef {
  _IsSongFavoriteProviderElement(super.provider);

  @override
  String get songId => (origin as IsSongFavoriteProvider).songId;
}

String _$playlistControllerHash() =>
    r'756747edbe2ca689bb02e97b78dc962ca3ab43d4';

/// Playlist controller
///
/// Copied from [PlaylistController].
@ProviderFor(PlaylistController)
final playlistControllerProvider =
    AutoDisposeAsyncNotifierProvider<PlaylistController, void>.internal(
  PlaylistController.new,
  name: r'playlistControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playlistControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlaylistController = AutoDisposeAsyncNotifier<void>;
String _$favoritesControllerHash() =>
    r'1fe10ca84fd4800ef646072944e1d565df6e86e1';

/// Favorites controller
///
/// Copied from [FavoritesController].
@ProviderFor(FavoritesController)
final favoritesControllerProvider =
    AutoDisposeAsyncNotifierProvider<FavoritesController, void>.internal(
  FavoritesController.new,
  name: r'favoritesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritesController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
