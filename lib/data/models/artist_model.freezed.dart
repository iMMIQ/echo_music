// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return _Artist.fromJson(json);
}

/// @nodoc
mixin _$Artist {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @AlbumArtConverter()
  @HiveField(2)
  AlbumArt? get artwork => throw _privateConstructorUsedError;
  @HiveField(3)
  List<Album> get albums => throw _privateConstructorUsedError;
  @HiveField(4)
  int get albumCount => throw _privateConstructorUsedError;
  @HiveField(5)
  int get songCount => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get genre => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get dateAdded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtistCopyWith<Artist> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistCopyWith<$Res> {
  factory $ArtistCopyWith(Artist value, $Res Function(Artist) then) =
      _$ArtistCopyWithImpl<$Res, Artist>;
  @useResult
  $Res call({
    String id,
    String name,
    @AlbumArtConverter() @HiveField(2) AlbumArt? artwork,
    @HiveField(3) List<Album> albums,
    @HiveField(4) int albumCount,
    @HiveField(5) int songCount,
    @HiveField(6) String? genre,
    @HiveField(7) DateTime? dateAdded,
  });

  $AlbumArtCopyWith<$Res>? get artwork;
}

/// @nodoc
class _$ArtistCopyWithImpl<$Res, $Val extends Artist>
    implements $ArtistCopyWith<$Res> {
  _$ArtistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? artwork = freezed,
    Object? albums = null,
    Object? albumCount = null,
    Object? songCount = null,
    Object? genre = freezed,
    Object? dateAdded = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            artwork: freezed == artwork
                ? _value.artwork
                : artwork // ignore: cast_nullable_to_non_nullable
                      as AlbumArt?,
            albums: null == albums
                ? _value.albums
                : albums // ignore: cast_nullable_to_non_nullable
                      as List<Album>,
            albumCount: null == albumCount
                ? _value.albumCount
                : albumCount // ignore: cast_nullable_to_non_nullable
                      as int,
            songCount: null == songCount
                ? _value.songCount
                : songCount // ignore: cast_nullable_to_non_nullable
                      as int,
            genre: freezed == genre
                ? _value.genre
                : genre // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateAdded: freezed == dateAdded
                ? _value.dateAdded
                : dateAdded // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
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
abstract class _$$ArtistImplCopyWith<$Res> implements $ArtistCopyWith<$Res> {
  factory _$$ArtistImplCopyWith(
    _$ArtistImpl value,
    $Res Function(_$ArtistImpl) then,
  ) = __$$ArtistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @AlbumArtConverter() @HiveField(2) AlbumArt? artwork,
    @HiveField(3) List<Album> albums,
    @HiveField(4) int albumCount,
    @HiveField(5) int songCount,
    @HiveField(6) String? genre,
    @HiveField(7) DateTime? dateAdded,
  });

  @override
  $AlbumArtCopyWith<$Res>? get artwork;
}

/// @nodoc
class __$$ArtistImplCopyWithImpl<$Res>
    extends _$ArtistCopyWithImpl<$Res, _$ArtistImpl>
    implements _$$ArtistImplCopyWith<$Res> {
  __$$ArtistImplCopyWithImpl(
    _$ArtistImpl _value,
    $Res Function(_$ArtistImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? artwork = freezed,
    Object? albums = null,
    Object? albumCount = null,
    Object? songCount = null,
    Object? genre = freezed,
    Object? dateAdded = freezed,
  }) {
    return _then(
      _$ArtistImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        artwork: freezed == artwork
            ? _value.artwork
            : artwork // ignore: cast_nullable_to_non_nullable
                  as AlbumArt?,
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
        albumCount: null == albumCount
            ? _value.albumCount
            : albumCount // ignore: cast_nullable_to_non_nullable
                  as int,
        songCount: null == songCount
            ? _value.songCount
            : songCount // ignore: cast_nullable_to_non_nullable
                  as int,
        genre: freezed == genre
            ? _value.genre
            : genre // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateAdded: freezed == dateAdded
            ? _value.dateAdded
            : dateAdded // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtistImpl extends _Artist {
  const _$ArtistImpl({
    required this.id,
    required this.name,
    @AlbumArtConverter() @HiveField(2) this.artwork,
    @HiveField(3) final List<Album> albums = const [],
    @HiveField(4) this.albumCount = 0,
    @HiveField(5) this.songCount = 0,
    @HiveField(6) this.genre,
    @HiveField(7) this.dateAdded,
  }) : _albums = albums,
       super._();

  factory _$ArtistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtistImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @AlbumArtConverter()
  @HiveField(2)
  final AlbumArt? artwork;
  final List<Album> _albums;
  @override
  @JsonKey()
  @HiveField(3)
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  @override
  @JsonKey()
  @HiveField(4)
  final int albumCount;
  @override
  @JsonKey()
  @HiveField(5)
  final int songCount;
  @override
  @HiveField(6)
  final String? genre;
  @override
  @HiveField(7)
  final DateTime? dateAdded;

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, artwork: $artwork, albums: $albums, albumCount: $albumCount, songCount: $songCount, genre: $genre, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.artwork, artwork) || other.artwork == artwork) &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            (identical(other.albumCount, albumCount) ||
                other.albumCount == albumCount) &&
            (identical(other.songCount, songCount) ||
                other.songCount == songCount) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    artwork,
    const DeepCollectionEquality().hash(_albums),
    albumCount,
    songCount,
    genre,
    dateAdded,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      __$$ArtistImplCopyWithImpl<_$ArtistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtistImplToJson(this);
  }
}

abstract class _Artist extends Artist {
  const factory _Artist({
    required final String id,
    required final String name,
    @AlbumArtConverter() @HiveField(2) final AlbumArt? artwork,
    @HiveField(3) final List<Album> albums,
    @HiveField(4) final int albumCount,
    @HiveField(5) final int songCount,
    @HiveField(6) final String? genre,
    @HiveField(7) final DateTime? dateAdded,
  }) = _$ArtistImpl;
  const _Artist._() : super._();

  factory _Artist.fromJson(Map<String, dynamic> json) = _$ArtistImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @AlbumArtConverter()
  @HiveField(2)
  AlbumArt? get artwork;
  @override
  @HiveField(3)
  List<Album> get albums;
  @override
  @HiveField(4)
  int get albumCount;
  @override
  @HiveField(5)
  int get songCount;
  @override
  @HiveField(6)
  String? get genre;
  @override
  @HiveField(7)
  DateTime? get dateAdded;
  @override
  @JsonKey(ignore: true)
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
