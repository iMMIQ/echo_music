// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlbumImpl _$$AlbumImplFromJson(Map<String, dynamic> json) => _$AlbumImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  artist: json['artist'] as String,
  artistId: json['artistId'] as String,
  artwork: json['artwork'] == null
      ? null
      : AlbumArt.fromJson(json['artwork'] as Map<String, dynamic>),
  year: (json['year'] as num?)?.toInt(),
  genre: json['genre'] as String?,
  songs:
      (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  songCount: (json['songCount'] as num?)?.toInt() ?? 0,
  totalDuration: json['totalDuration'] == null
      ? null
      : Duration(microseconds: (json['totalDuration'] as num).toInt()),
  dateAdded: json['dateAdded'] == null
      ? null
      : DateTime.parse(json['dateAdded'] as String),
);

Map<String, dynamic> _$$AlbumImplToJson(_$AlbumImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artist': instance.artist,
      'artistId': instance.artistId,
      'artwork': instance.artwork,
      'year': instance.year,
      'genre': instance.genre,
      'songs': instance.songs,
      'songCount': instance.songCount,
      'totalDuration': instance.totalDuration?.inMicroseconds,
      'dateAdded': instance.dateAdded?.toIso8601String(),
    };
