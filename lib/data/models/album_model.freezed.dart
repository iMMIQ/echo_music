// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return _Album.fromJson(json);
}

/// @nodoc
mixin _$Album {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get artistId => throw _privateConstructorUsedError;
  @HiveField(5)
  AlbumArt? get artwork => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get year => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get genre => throw _privateConstructorUsedError;
  @HiveField(8)
  List<Song> get songs => throw _privateConstructorUsedError;
  @HiveField(9)
  int get songCount => throw _privateConstructorUsedError;
  @HiveField(10)
  Duration? get totalDuration => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime? get dateAdded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumCopyWith<Album> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) then) =
      _$AlbumCopyWithImpl<$Res, Album>;
  @useResult
  $Res call({
    String id,
    String name,
    String artist,
    String artistId,
    @HiveField(5) AlbumArt? artwork,
    @HiveField(6) int? year,
    @HiveField(7) String? genre,
    @HiveField(8) List<Song> songs,
    @HiveField(9) int songCount,
    @HiveField(10) Duration? totalDuration,
    @HiveField(11) DateTime? dateAdded,
  });

  $AlbumArtCopyWith<$Res>? get artwork;
}

/// @nodoc
class _$AlbumCopyWithImpl<$Res, $Val extends Album>
    implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? artist = null,
    Object? artistId = null,
    Object? artwork = freezed,
    Object? year = freezed,
    Object? genre = freezed,
    Object? songs = null,
    Object? songCount = null,
    Object? totalDuration = freezed,
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
            artist: null == artist
                ? _value.artist
                : artist // ignore: cast_nullable_to_non_nullable
                      as String,
            artistId: null == artistId
                ? _value.artistId
                : artistId // ignore: cast_nullable_to_non_nullable
                      as String,
            artwork: freezed == artwork
                ? _value.artwork
                : artwork // ignore: cast_nullable_to_non_nullable
                      as AlbumArt?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
            genre: freezed == genre
                ? _value.genre
                : genre // ignore: cast_nullable_to_non_nullable
                      as String?,
            songs: null == songs
                ? _value.songs
                : songs // ignore: cast_nullable_to_non_nullable
                      as List<Song>,
            songCount: null == songCount
                ? _value.songCount
                : songCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDuration: freezed == totalDuration
                ? _value.totalDuration
                : totalDuration // ignore: cast_nullable_to_non_nullable
                      as Duration?,
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
abstract class _$$AlbumImplCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$$AlbumImplCopyWith(
    _$AlbumImpl value,
    $Res Function(_$AlbumImpl) then,
  ) = __$$AlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String artist,
    String artistId,
    @HiveField(5) AlbumArt? artwork,
    @HiveField(6) int? year,
    @HiveField(7) String? genre,
    @HiveField(8) List<Song> songs,
    @HiveField(9) int songCount,
    @HiveField(10) Duration? totalDuration,
    @HiveField(11) DateTime? dateAdded,
  });

  @override
  $AlbumArtCopyWith<$Res>? get artwork;
}

/// @nodoc
class __$$AlbumImplCopyWithImpl<$Res>
    extends _$AlbumCopyWithImpl<$Res, _$AlbumImpl>
    implements _$$AlbumImplCopyWith<$Res> {
  __$$AlbumImplCopyWithImpl(
    _$AlbumImpl _value,
    $Res Function(_$AlbumImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? artist = null,
    Object? artistId = null,
    Object? artwork = freezed,
    Object? year = freezed,
    Object? genre = freezed,
    Object? songs = null,
    Object? songCount = null,
    Object? totalDuration = freezed,
    Object? dateAdded = freezed,
  }) {
    return _then(
      _$AlbumImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        artist: null == artist
            ? _value.artist
            : artist // ignore: cast_nullable_to_non_nullable
                  as String,
        artistId: null == artistId
            ? _value.artistId
            : artistId // ignore: cast_nullable_to_non_nullable
                  as String,
        artwork: freezed == artwork
            ? _value.artwork
            : artwork // ignore: cast_nullable_to_non_nullable
                  as AlbumArt?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
        genre: freezed == genre
            ? _value.genre
            : genre // ignore: cast_nullable_to_non_nullable
                  as String?,
        songs: null == songs
            ? _value._songs
            : songs // ignore: cast_nullable_to_non_nullable
                  as List<Song>,
        songCount: null == songCount
            ? _value.songCount
            : songCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDuration: freezed == totalDuration
            ? _value.totalDuration
            : totalDuration // ignore: cast_nullable_to_non_nullable
                  as Duration?,
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
class _$AlbumImpl extends _Album {
  const _$AlbumImpl({
    required this.id,
    required this.name,
    required this.artist,
    required this.artistId,
    @HiveField(5) this.artwork,
    @HiveField(6) this.year,
    @HiveField(7) this.genre,
    @HiveField(8) final List<Song> songs = const [],
    @HiveField(9) this.songCount = 0,
    @HiveField(10) this.totalDuration,
    @HiveField(11) this.dateAdded,
  }) : _songs = songs,
       super._();

  factory _$AlbumImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlbumImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String artist;
  @override
  final String artistId;
  @override
  @HiveField(5)
  final AlbumArt? artwork;
  @override
  @HiveField(6)
  final int? year;
  @override
  @HiveField(7)
  final String? genre;
  final List<Song> _songs;
  @override
  @JsonKey()
  @HiveField(8)
  List<Song> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  @JsonKey()
  @HiveField(9)
  final int songCount;
  @override
  @HiveField(10)
  final Duration? totalDuration;
  @override
  @HiveField(11)
  final DateTime? dateAdded;

  @override
  String toString() {
    return 'Album(id: $id, name: $name, artist: $artist, artistId: $artistId, artwork: $artwork, year: $year, genre: $genre, songs: $songs, songCount: $songCount, totalDuration: $totalDuration, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.artistId, artistId) ||
                other.artistId == artistId) &&
            (identical(other.artwork, artwork) || other.artwork == artwork) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.songCount, songCount) ||
                other.songCount == songCount) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    artist,
    artistId,
    artwork,
    year,
    genre,
    const DeepCollectionEquality().hash(_songs),
    songCount,
    totalDuration,
    dateAdded,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      __$$AlbumImplCopyWithImpl<_$AlbumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlbumImplToJson(this);
  }
}

abstract class _Album extends Album {
  const factory _Album({
    required final String id,
    required final String name,
    required final String artist,
    required final String artistId,
    @HiveField(5) final AlbumArt? artwork,
    @HiveField(6) final int? year,
    @HiveField(7) final String? genre,
    @HiveField(8) final List<Song> songs,
    @HiveField(9) final int songCount,
    @HiveField(10) final Duration? totalDuration,
    @HiveField(11) final DateTime? dateAdded,
  }) = _$AlbumImpl;
  const _Album._() : super._();

  factory _Album.fromJson(Map<String, dynamic> json) = _$AlbumImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get artist;
  @override
  String get artistId;
  @override
  @HiveField(5)
  AlbumArt? get artwork;
  @override
  @HiveField(6)
  int? get year;
  @override
  @HiveField(7)
  String? get genre;
  @override
  @HiveField(8)
  List<Song> get songs;
  @override
  @HiveField(9)
  int get songCount;
  @override
  @HiveField(10)
  Duration? get totalDuration;
  @override
  @HiveField(11)
  DateTime? get dateAdded;
  @override
  @JsonKey(ignore: true)
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
