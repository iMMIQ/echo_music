// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'song_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Song _$SongFromJson(Map<String, dynamic> json) {
  return _Song.fromJson(json);
}

/// @nodoc
mixin _$Song {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get album => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  @AlbumArtConverter()
  @HiveField(7)
  AlbumArt? get albumArt => throw _privateConstructorUsedError;
  @HiveField(8)
  int? get trackNumber => throw _privateConstructorUsedError;
  @HiveField(9)
  int? get discNumber => throw _privateConstructorUsedError;
  @HiveField(10)
  int? get year => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get genre => throw _privateConstructorUsedError;
  @HiveField(12)
  int? get bitrate => throw _privateConstructorUsedError;
  @HiveField(13)
  String? get format => throw _privateConstructorUsedError;
  @HiveField(14)
  bool get isFavorite => throw _privateConstructorUsedError;
  @HiveField(15)
  int get playCount => throw _privateConstructorUsedError;
  @HiveField(16)
  DateTime? get lastPlayed => throw _privateConstructorUsedError;
  @HiveField(17)
  DateTime? get dateAdded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongCopyWith<Song> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongCopyWith<$Res> {
  factory $SongCopyWith(Song value, $Res Function(Song) then) =
      _$SongCopyWithImpl<$Res, Song>;
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String album,
      Duration duration,
      String filePath,
      @AlbumArtConverter() @HiveField(7) AlbumArt? albumArt,
      @HiveField(8) int? trackNumber,
      @HiveField(9) int? discNumber,
      @HiveField(10) int? year,
      @HiveField(11) String? genre,
      @HiveField(12) int? bitrate,
      @HiveField(13) String? format,
      @HiveField(14) bool isFavorite,
      @HiveField(15) int playCount,
      @HiveField(16) DateTime? lastPlayed,
      @HiveField(17) DateTime? dateAdded});

  $AlbumArtCopyWith<$Res>? get albumArt;
}

/// @nodoc
class _$SongCopyWithImpl<$Res, $Val extends Song>
    implements $SongCopyWith<$Res> {
  _$SongCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? album = null,
    Object? duration = null,
    Object? filePath = null,
    Object? albumArt = freezed,
    Object? trackNumber = freezed,
    Object? discNumber = freezed,
    Object? year = freezed,
    Object? genre = freezed,
    Object? bitrate = freezed,
    Object? format = freezed,
    Object? isFavorite = null,
    Object? playCount = null,
    Object? lastPlayed = freezed,
    Object? dateAdded = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      albumArt: freezed == albumArt
          ? _value.albumArt
          : albumArt // ignore: cast_nullable_to_non_nullable
              as AlbumArt?,
      trackNumber: freezed == trackNumber
          ? _value.trackNumber
          : trackNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      discNumber: freezed == discNumber
          ? _value.discNumber
          : discNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      bitrate: freezed == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastPlayed: freezed == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateAdded: freezed == dateAdded
          ? _value.dateAdded
          : dateAdded // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AlbumArtCopyWith<$Res>? get albumArt {
    if (_value.albumArt == null) {
      return null;
    }

    return $AlbumArtCopyWith<$Res>(_value.albumArt!, (value) {
      return _then(_value.copyWith(albumArt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SongImplCopyWith<$Res> implements $SongCopyWith<$Res> {
  factory _$$SongImplCopyWith(
          _$SongImpl value, $Res Function(_$SongImpl) then) =
      __$$SongImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String album,
      Duration duration,
      String filePath,
      @AlbumArtConverter() @HiveField(7) AlbumArt? albumArt,
      @HiveField(8) int? trackNumber,
      @HiveField(9) int? discNumber,
      @HiveField(10) int? year,
      @HiveField(11) String? genre,
      @HiveField(12) int? bitrate,
      @HiveField(13) String? format,
      @HiveField(14) bool isFavorite,
      @HiveField(15) int playCount,
      @HiveField(16) DateTime? lastPlayed,
      @HiveField(17) DateTime? dateAdded});

  @override
  $AlbumArtCopyWith<$Res>? get albumArt;
}

/// @nodoc
class __$$SongImplCopyWithImpl<$Res>
    extends _$SongCopyWithImpl<$Res, _$SongImpl>
    implements _$$SongImplCopyWith<$Res> {
  __$$SongImplCopyWithImpl(_$SongImpl _value, $Res Function(_$SongImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? album = null,
    Object? duration = null,
    Object? filePath = null,
    Object? albumArt = freezed,
    Object? trackNumber = freezed,
    Object? discNumber = freezed,
    Object? year = freezed,
    Object? genre = freezed,
    Object? bitrate = freezed,
    Object? format = freezed,
    Object? isFavorite = null,
    Object? playCount = null,
    Object? lastPlayed = freezed,
    Object? dateAdded = freezed,
  }) {
    return _then(_$SongImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      albumArt: freezed == albumArt
          ? _value.albumArt
          : albumArt // ignore: cast_nullable_to_non_nullable
              as AlbumArt?,
      trackNumber: freezed == trackNumber
          ? _value.trackNumber
          : trackNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      discNumber: freezed == discNumber
          ? _value.discNumber
          : discNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String?,
      bitrate: freezed == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastPlayed: freezed == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateAdded: freezed == dateAdded
          ? _value.dateAdded
          : dateAdded // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SongImpl extends _Song {
  const _$SongImpl(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.duration,
      required this.filePath,
      @AlbumArtConverter() @HiveField(7) this.albumArt,
      @HiveField(8) this.trackNumber,
      @HiveField(9) this.discNumber,
      @HiveField(10) this.year,
      @HiveField(11) this.genre,
      @HiveField(12) this.bitrate,
      @HiveField(13) this.format,
      @HiveField(14) this.isFavorite = false,
      @HiveField(15) this.playCount = 0,
      @HiveField(16) this.lastPlayed,
      @HiveField(17) this.dateAdded})
      : super._();

  factory _$SongImpl.fromJson(Map<String, dynamic> json) =>
      _$$SongImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String album;
  @override
  final Duration duration;
  @override
  final String filePath;
  @override
  @AlbumArtConverter()
  @HiveField(7)
  final AlbumArt? albumArt;
  @override
  @HiveField(8)
  final int? trackNumber;
  @override
  @HiveField(9)
  final int? discNumber;
  @override
  @HiveField(10)
  final int? year;
  @override
  @HiveField(11)
  final String? genre;
  @override
  @HiveField(12)
  final int? bitrate;
  @override
  @HiveField(13)
  final String? format;
  @override
  @JsonKey()
  @HiveField(14)
  final bool isFavorite;
  @override
  @JsonKey()
  @HiveField(15)
  final int playCount;
  @override
  @HiveField(16)
  final DateTime? lastPlayed;
  @override
  @HiveField(17)
  final DateTime? dateAdded;

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artist, album: $album, duration: $duration, filePath: $filePath, albumArt: $albumArt, trackNumber: $trackNumber, discNumber: $discNumber, year: $year, genre: $genre, bitrate: $bitrate, format: $format, isFavorite: $isFavorite, playCount: $playCount, lastPlayed: $lastPlayed, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.albumArt, albumArt) ||
                other.albumArt == albumArt) &&
            (identical(other.trackNumber, trackNumber) ||
                other.trackNumber == trackNumber) &&
            (identical(other.discNumber, discNumber) ||
                other.discNumber == discNumber) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      artist,
      album,
      duration,
      filePath,
      albumArt,
      trackNumber,
      discNumber,
      year,
      genre,
      bitrate,
      format,
      isFavorite,
      playCount,
      lastPlayed,
      dateAdded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongImplCopyWith<_$SongImpl> get copyWith =>
      __$$SongImplCopyWithImpl<_$SongImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SongImplToJson(
      this,
    );
  }
}

abstract class _Song extends Song {
  const factory _Song(
      {required final String id,
      required final String title,
      required final String artist,
      required final String album,
      required final Duration duration,
      required final String filePath,
      @AlbumArtConverter() @HiveField(7) final AlbumArt? albumArt,
      @HiveField(8) final int? trackNumber,
      @HiveField(9) final int? discNumber,
      @HiveField(10) final int? year,
      @HiveField(11) final String? genre,
      @HiveField(12) final int? bitrate,
      @HiveField(13) final String? format,
      @HiveField(14) final bool isFavorite,
      @HiveField(15) final int playCount,
      @HiveField(16) final DateTime? lastPlayed,
      @HiveField(17) final DateTime? dateAdded}) = _$SongImpl;
  const _Song._() : super._();

  factory _Song.fromJson(Map<String, dynamic> json) = _$SongImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get artist;
  @override
  String get album;
  @override
  Duration get duration;
  @override
  String get filePath;
  @override
  @AlbumArtConverter()
  @HiveField(7)
  AlbumArt? get albumArt;
  @override
  @HiveField(8)
  int? get trackNumber;
  @override
  @HiveField(9)
  int? get discNumber;
  @override
  @HiveField(10)
  int? get year;
  @override
  @HiveField(11)
  String? get genre;
  @override
  @HiveField(12)
  int? get bitrate;
  @override
  @HiveField(13)
  String? get format;
  @override
  @HiveField(14)
  bool get isFavorite;
  @override
  @HiveField(15)
  int get playCount;
  @override
  @HiveField(16)
  DateTime? get lastPlayed;
  @override
  @HiveField(17)
  DateTime? get dateAdded;
  @override
  @JsonKey(ignore: true)
  _$$SongImplCopyWith<_$SongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlbumArt _$AlbumArtFromJson(Map<String, dynamic> json) {
  return _AlbumArt.fromJson(json);
}

/// @nodoc
mixin _$AlbumArt {
  String get path => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  String? get mimeType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumArtCopyWith<AlbumArt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumArtCopyWith<$Res> {
  factory $AlbumArtCopyWith(AlbumArt value, $Res Function(AlbumArt) then) =
      _$AlbumArtCopyWithImpl<$Res, AlbumArt>;
  @useResult
  $Res call({String path, int width, int height, String? mimeType});
}

/// @nodoc
class _$AlbumArtCopyWithImpl<$Res, $Val extends AlbumArt>
    implements $AlbumArtCopyWith<$Res> {
  _$AlbumArtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? width = null,
    Object? height = null,
    Object? mimeType = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlbumArtImplCopyWith<$Res>
    implements $AlbumArtCopyWith<$Res> {
  factory _$$AlbumArtImplCopyWith(
          _$AlbumArtImpl value, $Res Function(_$AlbumArtImpl) then) =
      __$$AlbumArtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, int width, int height, String? mimeType});
}

/// @nodoc
class __$$AlbumArtImplCopyWithImpl<$Res>
    extends _$AlbumArtCopyWithImpl<$Res, _$AlbumArtImpl>
    implements _$$AlbumArtImplCopyWith<$Res> {
  __$$AlbumArtImplCopyWithImpl(
      _$AlbumArtImpl _value, $Res Function(_$AlbumArtImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? width = null,
    Object? height = null,
    Object? mimeType = freezed,
  }) {
    return _then(_$AlbumArtImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlbumArtImpl implements _AlbumArt {
  const _$AlbumArtImpl(
      {required this.path, this.width = 0, this.height = 0, this.mimeType});

  factory _$AlbumArtImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlbumArtImplFromJson(json);

  @override
  final String path;
  @override
  @JsonKey()
  final int width;
  @override
  @JsonKey()
  final int height;
  @override
  final String? mimeType;

  @override
  String toString() {
    return 'AlbumArt(path: $path, width: $width, height: $height, mimeType: $mimeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumArtImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, width, height, mimeType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumArtImplCopyWith<_$AlbumArtImpl> get copyWith =>
      __$$AlbumArtImplCopyWithImpl<_$AlbumArtImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlbumArtImplToJson(
      this,
    );
  }
}

abstract class _AlbumArt implements AlbumArt {
  const factory _AlbumArt(
      {required final String path,
      final int width,
      final int height,
      final String? mimeType}) = _$AlbumArtImpl;

  factory _AlbumArt.fromJson(Map<String, dynamic> json) =
      _$AlbumArtImpl.fromJson;

  @override
  String get path;
  @override
  int get width;
  @override
  int get height;
  @override
  String? get mimeType;
  @override
  @JsonKey(ignore: true)
  _$$AlbumArtImplCopyWith<_$AlbumArtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
