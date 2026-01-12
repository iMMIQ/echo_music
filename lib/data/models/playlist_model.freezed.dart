// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return _Playlist.fromJson(json);
}

/// @nodoc
mixin _$Playlist {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(3)
  List<Song> get songs => throw _privateConstructorUsedError;
  @HiveField(4)
  AlbumArt? get artwork => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(7)
  bool get isSmartPlaylist => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get smartPlaylistRules => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistCopyWith<Playlist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistCopyWith<$Res> {
  factory $PlaylistCopyWith(Playlist value, $Res Function(Playlist) then) =
      _$PlaylistCopyWithImpl<$Res, Playlist>;
  @useResult
  $Res call(
      {String id,
      String name,
      @HiveField(2) String? description,
      @HiveField(3) List<Song> songs,
      @HiveField(4) AlbumArt? artwork,
      DateTime createdAt,
      @HiveField(6) DateTime? updatedAt,
      @HiveField(7) bool isSmartPlaylist,
      @HiveField(8) String? smartPlaylistRules});

  $AlbumArtCopyWith<$Res>? get artwork;
}

/// @nodoc
class _$PlaylistCopyWithImpl<$Res, $Val extends Playlist>
    implements $PlaylistCopyWith<$Res> {
  _$PlaylistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? songs = null,
    Object? artwork = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isSmartPlaylist = null,
    Object? smartPlaylistRules = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      artwork: freezed == artwork
          ? _value.artwork
          : artwork // ignore: cast_nullable_to_non_nullable
              as AlbumArt?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSmartPlaylist: null == isSmartPlaylist
          ? _value.isSmartPlaylist
          : isSmartPlaylist // ignore: cast_nullable_to_non_nullable
              as bool,
      smartPlaylistRules: freezed == smartPlaylistRules
          ? _value.smartPlaylistRules
          : smartPlaylistRules // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AlbumArtCopyWith<$Res>? get artwork {
    if (_value.artwork == null) {
      return null;
    }

    return $AlbumArtCopyWith<$Res>(_value.artwork!, (value) {
      return _then(_value.copyWith(artwork: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaylistImplCopyWith<$Res>
    implements $PlaylistCopyWith<$Res> {
  factory _$$PlaylistImplCopyWith(
          _$PlaylistImpl value, $Res Function(_$PlaylistImpl) then) =
      __$$PlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @HiveField(2) String? description,
      @HiveField(3) List<Song> songs,
      @HiveField(4) AlbumArt? artwork,
      DateTime createdAt,
      @HiveField(6) DateTime? updatedAt,
      @HiveField(7) bool isSmartPlaylist,
      @HiveField(8) String? smartPlaylistRules});

  @override
  $AlbumArtCopyWith<$Res>? get artwork;
}

/// @nodoc
class __$$PlaylistImplCopyWithImpl<$Res>
    extends _$PlaylistCopyWithImpl<$Res, _$PlaylistImpl>
    implements _$$PlaylistImplCopyWith<$Res> {
  __$$PlaylistImplCopyWithImpl(
      _$PlaylistImpl _value, $Res Function(_$PlaylistImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? songs = null,
    Object? artwork = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isSmartPlaylist = null,
    Object? smartPlaylistRules = freezed,
  }) {
    return _then(_$PlaylistImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      artwork: freezed == artwork
          ? _value.artwork
          : artwork // ignore: cast_nullable_to_non_nullable
              as AlbumArt?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSmartPlaylist: null == isSmartPlaylist
          ? _value.isSmartPlaylist
          : isSmartPlaylist // ignore: cast_nullable_to_non_nullable
              as bool,
      smartPlaylistRules: freezed == smartPlaylistRules
          ? _value.smartPlaylistRules
          : smartPlaylistRules // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaylistImpl extends _Playlist {
  const _$PlaylistImpl(
      {required this.id,
      required this.name,
      @HiveField(2) this.description,
      @HiveField(3) final List<Song> songs = const [],
      @HiveField(4) this.artwork,
      required this.createdAt,
      @HiveField(6) this.updatedAt,
      @HiveField(7) this.isSmartPlaylist = false,
      @HiveField(8) this.smartPlaylistRules})
      : _songs = songs,
        super._();

  factory _$PlaylistImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaylistImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @HiveField(2)
  final String? description;
  final List<Song> _songs;
  @override
  @JsonKey()
  @HiveField(3)
  List<Song> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  @HiveField(4)
  final AlbumArt? artwork;
  @override
  final DateTime createdAt;
  @override
  @HiveField(6)
  final DateTime? updatedAt;
  @override
  @JsonKey()
  @HiveField(7)
  final bool isSmartPlaylist;
  @override
  @HiveField(8)
  final String? smartPlaylistRules;

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, description: $description, songs: $songs, artwork: $artwork, createdAt: $createdAt, updatedAt: $updatedAt, isSmartPlaylist: $isSmartPlaylist, smartPlaylistRules: $smartPlaylistRules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.artwork, artwork) || other.artwork == artwork) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isSmartPlaylist, isSmartPlaylist) ||
                other.isSmartPlaylist == isSmartPlaylist) &&
            (identical(other.smartPlaylistRules, smartPlaylistRules) ||
                other.smartPlaylistRules == smartPlaylistRules));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_songs),
      artwork,
      createdAt,
      updatedAt,
      isSmartPlaylist,
      smartPlaylistRules);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      __$$PlaylistImplCopyWithImpl<_$PlaylistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaylistImplToJson(
      this,
    );
  }
}

abstract class _Playlist extends Playlist {
  const factory _Playlist(
      {required final String id,
      required final String name,
      @HiveField(2) final String? description,
      @HiveField(3) final List<Song> songs,
      @HiveField(4) final AlbumArt? artwork,
      required final DateTime createdAt,
      @HiveField(6) final DateTime? updatedAt,
      @HiveField(7) final bool isSmartPlaylist,
      @HiveField(8) final String? smartPlaylistRules}) = _$PlaylistImpl;
  const _Playlist._() : super._();

  factory _Playlist.fromJson(Map<String, dynamic> json) =
      _$PlaylistImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @HiveField(2)
  String? get description;
  @override
  @HiveField(3)
  List<Song> get songs;
  @override
  @HiveField(4)
  AlbumArt? get artwork;
  @override
  DateTime get createdAt;
  @override
  @HiveField(6)
  DateTime? get updatedAt;
  @override
  @HiveField(7)
  bool get isSmartPlaylist;
  @override
  @HiveField(8)
  String? get smartPlaylistRules;
  @override
  @JsonKey(ignore: true)
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
