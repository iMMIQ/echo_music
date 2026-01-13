import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'song_model.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

/// Album model stored in Hive
@freezed
class Album with _$Album {
  const factory Album({
    required String id,
    required String name,
    required String artist,
    required String artistId,
    @HiveField(5) AlbumArt? artwork,
    @HiveField(6) int? year,
    @HiveField(7) String? genre,
    @Default([]) @HiveField(8) List<Song> songs,
    @Default(0) @HiveField(9) int songCount,
    @HiveField(10) Duration? totalDuration,
    @HiveField(11) DateTime? dateAdded,
  }) = _Album;
  const Album._();

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}

/// Extension for Hive adapter
class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 2;

  @override
  Album read(BinaryReader reader) {
    return Album(
      id: reader.read(),
      name: reader.read(),
      artist: reader.read(),
      artistId: reader.read(),
      artwork: reader.read(),
      year: reader.read(),
      genre: reader.read(),
      songs: reader.read(),
      songCount: reader.read(),
      totalDuration: reader.read(),
      dateAdded: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.artist);
    writer.write(obj.artistId);
    writer.write(obj.artwork);
    writer.write(obj.year);
    writer.write(obj.genre);
    writer.write(obj.songs);
    writer.write(obj.songCount);
    writer.write(obj.totalDuration);
    writer.write(obj.dateAdded);
  }
}
