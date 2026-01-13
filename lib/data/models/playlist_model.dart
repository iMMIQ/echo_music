import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'song_model.dart';

part 'playlist_model.freezed.dart';
part 'playlist_model.g.dart';

/// Playlist model stored in Hive
@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String name,
    required DateTime createdAt,
    @HiveField(2) String? description,
    @Default([]) @HiveField(3) List<Song> songs,
    @HiveField(4) AlbumArt? artwork,
    @HiveField(6) DateTime? updatedAt,
    @Default(false) @HiveField(7) bool isSmartPlaylist,
    @HiveField(8) String? smartPlaylistRules,
  }) = _Playlist;
  const Playlist._();

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  /// Get track count
  int get trackCount => songs.length;

  /// Get total duration
  Duration get totalDuration =>
      songs.fold(Duration.zero, (sum, song) => sum + song.duration);
}

/// Extension for Hive adapter
class PlaylistAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 4;

  @override
  Playlist read(BinaryReader reader) {
    return Playlist(
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      songs: reader.read(),
      artwork: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
      isSmartPlaylist: reader.read(),
      smartPlaylistRules: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.songs);
    writer.write(obj.artwork);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
    writer.write(obj.isSmartPlaylist);
    writer.write(obj.smartPlaylistRules);
  }
}
