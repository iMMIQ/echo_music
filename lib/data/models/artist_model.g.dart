// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArtistImpl _$$ArtistImplFromJson(Map<String, dynamic> json) => _$ArtistImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      artwork: const AlbumArtConverter()
          .fromJson(json['artwork'] as Map<String, dynamic>?),
      albums: (json['albums'] as List<dynamic>?)
              ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      albumCount: (json['albumCount'] as num?)?.toInt() ?? 0,
      songCount: (json['songCount'] as num?)?.toInt() ?? 0,
      genre: json['genre'] as String?,
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
    );

Map<String, dynamic> _$$ArtistImplToJson(_$ArtistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artwork': const AlbumArtConverter().toJson(instance.artwork),
      'albums': instance.albums,
      'albumCount': instance.albumCount,
      'songCount': instance.songCount,
      'genre': instance.genre,
      'dateAdded': instance.dateAdded?.toIso8601String(),
    };
