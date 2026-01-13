import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'album_model.dart';
import 'song_model.dart';

part 'artist_model.freezed.dart';
part 'artist_model.g.dart';

/// Artist model stored in Hive
@freezed
class Artist with _$Artist {
  const factory Artist({
    required String id,
    required String name,
    @AlbumArtConverter() @HiveField(2) AlbumArt? artwork,
    @Default([]) @HiveField(3) List<Album> albums,
    @Default(0) @HiveField(4) int albumCount,
    @Default(0) @HiveField(5) int songCount,
    @HiveField(6) String? genre,
    @HiveField(7) DateTime? dateAdded,
  }) = _Artist;
  const Artist._();

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}

/// Extension for Hive adapter
class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final int typeId = 3;

  @override
  Artist read(BinaryReader reader) {
    return Artist(
      id: reader.read(),
      name: reader.read(),
      artwork: reader.read(),
      albums: reader.read(),
      albumCount: reader.read(),
      songCount: reader.read(),
      genre: reader.read(),
      dateAdded: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.artwork);
    writer.write(obj.albums);
    writer.write(obj.albumCount);
    writer.write(obj.songCount);
    writer.write(obj.genre);
    writer.write(obj.dateAdded);
  }
}
