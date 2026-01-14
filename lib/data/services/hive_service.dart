import 'package:hive_flutter/hive_flutter.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/playlist_model.dart';
import '../models/settings_model.dart';
import '../models/song_model.dart';

/// Box names for different data types
class HiveBoxes {
  static const String songs = 'songs';
  static const String albums = 'albums';
  static const String artists = 'artists';
  static const String playlists = 'playlists';
  static const String playbackHistory = 'playback_history';
  static const String favorites = 'favorites';
  static const String settings = 'settings';
}

/// Hive service for managing database initialization and access
class HiveService {
  /// Initialize Hive and register all adapters
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();

    // Register all type adapters
    _registerAdapters();
  }

  /// Register all type adapters
  static void _registerAdapters() {
    // Register adapters - order matters, register dependencies first
    Hive
      ..registerAdapter(AlbumArtAdapter())
      ..registerAdapter(SongAdapter())
      ..registerAdapter(AlbumAdapter())
      ..registerAdapter(ArtistAdapter())
      ..registerAdapter(PlaylistAdapter())
      ..registerAdapter(AppSettingsAdapter());
  }

  /// Open all required boxes
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<Song>(HiveBoxes.songs),
      Hive.openBox<Album>(HiveBoxes.albums),
      Hive.openBox<Artist>(HiveBoxes.artists),
      Hive.openBox<Playlist>(HiveBoxes.playlists),
      Hive.openBox<dynamic>(HiveBoxes.playbackHistory),
      Hive.openBox<String>(HiveBoxes.favorites),
      Hive.openBox<AppSettings>(HiveBoxes.settings),
    ]);
  }

  /// Get a box by type
  static Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  /// Close all boxes
  static Future<void> closeBoxes() async {
    await Hive.close();
  }

  /// Clear all data (useful for testing or logout)
  static Future<void> clearAllData() async {
    await Hive.box<Song>(HiveBoxes.songs).clear();
    await Hive.box<Album>(HiveBoxes.albums).clear();
    await Hive.box<Artist>(HiveBoxes.artists).clear();
    await Hive.box<Playlist>(HiveBoxes.playlists).clear();
    await Hive.box<dynamic>(HiveBoxes.playbackHistory).clear();
    await Hive.box<String>(HiveBoxes.favorites).clear();
    await Hive.box<AppSettings>(HiveBoxes.settings).clear();
  }
}
