import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'song_model.freezed.dart';
part 'song_model.g.dart';

/// Song model stored in Hive
@freezed
class Song with _$Song {
  const factory Song({
    required String id,
    required String title,
    required String artist,
    required String album,
    required Duration duration,
    required String filePath,
    @AlbumArtConverter() @HiveField(7) AlbumArt? albumArt,
    @HiveField(8) int? trackNumber,
    @HiveField(9) int? discNumber,
    @HiveField(10) int? year,
    @HiveField(11) String? genre,
    @HiveField(12) int? bitrate,
    @HiveField(13) String? format,
    @Default(false) @HiveField(14) bool isFavorite,
    @Default(0) @HiveField(15) int playCount,
    @HiveField(16) DateTime? lastPlayed,
    @HiveField(17) DateTime? dateAdded,
  }) = _Song;
  const Song._();

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}

/// Album art model
@HiveType(typeId: 1)
@freezed
class AlbumArt with _$AlbumArt {
  const factory AlbumArt({
    @HiveField(0) required String path,
    @HiveField(1) @Default(0) int width,
    @HiveField(2) @Default(0) int height,
    @HiveField(3) String? mimeType,
  }) = _AlbumArt;

  factory AlbumArt.fromJson(Map<String, dynamic> json) =>
      _$AlbumArtFromJson(json);
}

/// Album art JSON converter
class AlbumArtConverter
    implements JsonConverter<AlbumArt?, Map<String, dynamic>?> {
  const AlbumArtConverter();

  @override
  AlbumArt? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return AlbumArt(
      path: json['path'] as String,
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      mimeType: json['mimeType'] as String?,
    );
  }

  @override
  Map<String, dynamic>? toJson(AlbumArt? object) {
    if (object == null) return null;
    return {
      'path': object.path,
      'width': object.width,
      'height': object.height,
      'mimeType': object.mimeType,
    };
  }
}

/// Extension for Hive adapter
class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) {
    return Song(
      id: reader.read(),
      title: reader.read(),
      artist: reader.read(),
      album: reader.read(),
      duration: reader.read(),
      filePath: reader.read(),
      albumArt: reader.read(),
      trackNumber: reader.read(),
      discNumber: reader.read(),
      year: reader.read(),
      genre: reader.read(),
      bitrate: reader.read(),
      format: reader.read(),
      isFavorite: reader.read(),
      playCount: reader.read(),
      lastPlayed: reader.read(),
      dateAdded: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.artist);
    writer.write(obj.album);
    writer.write(obj.duration);
    writer.write(obj.filePath);
    writer.write(obj.albumArt);
    writer.write(obj.trackNumber);
    writer.write(obj.discNumber);
    writer.write(obj.year);
    writer.write(obj.genre);
    writer.write(obj.bitrate);
    writer.write(obj.format);
    writer.write(obj.isFavorite);
    writer.write(obj.playCount);
    writer.write(obj.lastPlayed);
    writer.write(obj.dateAdded);
  }
}
