// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumArtAdapter extends TypeAdapter<AlbumArt> {
  @override
  final int typeId = 1;

  @override
  AlbumArt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumArt(
      path: fields[0] as String,
      width: fields[1] as int,
      height: fields[2] as int,
      mimeType: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumArt obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.mimeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumArtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongImpl _$$SongImplFromJson(Map<String, dynamic> json) => _$SongImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      filePath: json['filePath'] as String,
      albumArt: const AlbumArtConverter()
          .fromJson(json['albumArt'] as Map<String, dynamic>?),
      trackNumber: (json['trackNumber'] as num?)?.toInt(),
      discNumber: (json['discNumber'] as num?)?.toInt(),
      year: (json['year'] as num?)?.toInt(),
      genre: json['genre'] as String?,
      bitrate: (json['bitrate'] as num?)?.toInt(),
      format: json['format'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      playCount: (json['playCount'] as num?)?.toInt() ?? 0,
      lastPlayed: json['lastPlayed'] == null
          ? null
          : DateTime.parse(json['lastPlayed'] as String),
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
    );

Map<String, dynamic> _$$SongImplToJson(_$SongImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'album': instance.album,
      'duration': instance.duration.inMicroseconds,
      'filePath': instance.filePath,
      'albumArt': const AlbumArtConverter().toJson(instance.albumArt),
      'trackNumber': instance.trackNumber,
      'discNumber': instance.discNumber,
      'year': instance.year,
      'genre': instance.genre,
      'bitrate': instance.bitrate,
      'format': instance.format,
      'isFavorite': instance.isFavorite,
      'playCount': instance.playCount,
      'lastPlayed': instance.lastPlayed?.toIso8601String(),
      'dateAdded': instance.dateAdded?.toIso8601String(),
    };

_$AlbumArtImpl _$$AlbumArtImplFromJson(Map<String, dynamic> json) =>
    _$AlbumArtImpl(
      path: json['path'] as String,
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
      mimeType: json['mimeType'] as String?,
    );

Map<String, dynamic> _$$AlbumArtImplToJson(_$AlbumArtImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'width': instance.width,
      'height': instance.height,
      'mimeType': instance.mimeType,
    };
