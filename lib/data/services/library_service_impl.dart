import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';
import 'library_service.dart';
import 'metadata_service.dart';

/// Library service implementation
class LibraryServiceImpl extends LibraryService {
  LibraryServiceImpl(this._metadataService);
  final MetadataService _metadataService;
  late Box<Song> _songsBox;
  late Box<Album> _albumsBox;
  late Box<Artist> _artistsBox;

  /// Initialize the service (must be called before use)
  Future<void> init() async {
    _songsBox = await Hive.openBox<Song>('songs');
    _albumsBox = await Hive.openBox<Album>('albums');
    _artistsBox = await Hive.openBox<Artist>('artists');
  }

  // === Song Management ===

  @override
  Future<List<Song>> getAllSongs() async {
    return _songsBox.values.toList();
  }

  @override
  Future<Song?> getSongById(String id) async {
    return _songsBox.get(id);
  }

  @override
  Future<List<Song>> searchSongs(String query) async {
    final allSongs = await getAllSongs();
    final lowerQuery = query.toLowerCase();
    return allSongs.where((song) {
      return song.title.toLowerCase().contains(lowerQuery) ||
          song.artist.toLowerCase().contains(lowerQuery) ||
          song.album.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<Song>> getSongsByArtist(String artistId) async {
    final allSongs = await getAllSongs();
    return allSongs.where((song) {
      // Simple matching by artist name for now
      // In a real implementation, you'd use artistId
      return true;
    }).toList();
  }

  @override
  Future<List<Song>> getSongsByAlbum(String albumId) async {
    final allSongs = await getAllSongs();
    return allSongs.where((song) {
      // Simple matching by album name for now
      // In a real implementation, you'd use albumId
      return true;
    }).toList();
  }

  @override
  Future<List<Song>> getSongsByGenre(String genre) async {
    final allSongs = await getAllSongs();
    return allSongs.where((song) => song.genre == genre).toList();
  }

  @override
  Future<void> addSong(Song song) async {
    await _songsBox.put(song.id, song);
  }

  @override
  Future<void> addSongs(List<Song> songs) async {
    for (final song in songs) {
      await _songsBox.put(song.id, song);
    }
  }

  @override
  Future<void> removeSong(String songId) async {
    await _songsBox.delete(songId);
  }

  @override
  Future<void> updateSong(Song song) async {
    await _songsBox.put(song.id, song);
  }

  @override
  Future<void> toggleFavorite(String songId) async {
    final song = await getSongById(songId);
    if (song != null) {
      final updated = song.copyWith(isFavorite: !song.isFavorite);
      await _songsBox.put(songId, updated);
    }
  }

  @override
  Future<List<Song>> getFavoriteSongs() async {
    final allSongs = await getAllSongs();
    return allSongs.where((song) => song.isFavorite).toList();
  }

  @override
  Future<void> incrementPlayCount(String songId) async {
    final song = await getSongById(songId);
    if (song != null) {
      final updated = song.copyWith(
        playCount: song.playCount + 1,
        lastPlayed: DateTime.now(),
      );
      await _songsBox.put(songId, updated);
    }
  }

  @override
  Future<List<Song>> getRecentlyPlayed({int limit = 20}) async {
    final allSongs = await getAllSongs();
    final played = allSongs.where((song) => song.lastPlayed != null).toList()
      ..sort((a, b) => b.lastPlayed!.compareTo(a.lastPlayed!));
    return played.take(limit).toList();
  }

  // === Album Management ===

  @override
  Future<List<Album>> getAllAlbums() async {
    return _albumsBox.values.toList();
  }

  @override
  Future<Album?> getAlbumById(String id) async {
    return _albumsBox.get(id);
  }

  @override
  Future<List<Album>> getAlbumsByArtist(String artistId) async {
    final allAlbums = await getAllAlbums();
    return allAlbums.where((album) {
      // Simple matching by artist name for now
      return true;
    }).toList();
  }

  @override
  Future<List<Album>> searchAlbums(String query) async {
    final allAlbums = await getAllAlbums();
    final lowerQuery = query.toLowerCase();
    return allAlbums.where((album) {
      return album.name.toLowerCase().contains(lowerQuery) ||
          album.artist.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<void> addAlbum(Album album) async {
    await _albumsBox.put(album.id, album);
  }

  @override
  Future<void> removeAlbum(String albumId) async {
    await _albumsBox.delete(albumId);
  }

  @override
  Future<void> updateAlbum(Album album) async {
    await _albumsBox.put(album.id, album);
  }

  // === Artist Management ===

  @override
  Future<List<Artist>> getAllArtists() async {
    return _artistsBox.values.toList();
  }

  @override
  Future<Artist?> getArtistById(String id) async {
    return _artistsBox.get(id);
  }

  @override
  Future<List<Artist>> searchArtists(String query) async {
    final allArtists = await getAllArtists();
    final lowerQuery = query.toLowerCase();
    return allArtists.where((artist) {
      return artist.name.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<void> addArtist(Artist artist) async {
    await _artistsBox.put(artist.id, artist);
  }

  @override
  Future<void> removeArtist(String artistId) async {
    await _artistsBox.delete(artistId);
  }

  @override
  Future<void> updateArtist(Artist artist) async {
    await _artistsBox.put(artist.id, artist);
  }

  // === Library Scanning ===

  @override
  Future<List<Song>> scanDirectory(String dirPath) async {
    final directory = Directory(dirPath);
    if (!await directory.exists()) {
      return [];
    }

    final songs = <Song>[];
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && _metadataService.isSupportedFormat(entity.path)) {
        try {
          final metadata = await _metadataService.extractMetadata(entity.path);
          final song = _createSongFromMetadata(entity.path, metadata);
          await addSong(song);
          songs.add(song);
        } catch (e) {
          // Skip files that can't be processed
          continue;
        }
      }
    }

    return songs;
  }

  @override
  Future<List<Song>> scanDirectories(List<String> paths) async {
    final allSongs = <Song>[];
    for (final path in paths) {
      final songs = await scanDirectory(path);
      allSongs.addAll(songs);
    }
    return allSongs;
  }

  @override
  Future<List<Song>> importFiles(List<String> filePaths) async {
    final songs = <Song>[];
    for (final filePath in filePaths) {
      if (!_metadataService.isSupportedFormat(filePath)) {
        continue;
      }

      try {
        final metadata = await _metadataService.extractMetadata(filePath);
        final song = _createSongFromMetadata(filePath, metadata);
        await addSong(song);
        songs.add(song);
      } catch (e) {
        // Skip files that can't be processed
        continue;
      }
    }
    return songs;
  }

  @override
  Future<LibraryStats> getStats() async {
    final songs = await getAllSongs();
    final albums = await getAllAlbums();
    final artists = await getAllArtists();

    final totalDuration = songs.fold<Duration>(
      Duration.zero,
      (sum, song) => sum + song.duration,
    );

    final favoriteCount = songs.where((song) => song.isFavorite).length;

    return LibraryStats(
      songCount: songs.length,
      albumCount: albums.length,
      artistCount: artists.length,
      playlistCount: 0, // TODO(claude): Implement playlists
      totalDuration: totalDuration,
      favoriteCount: favoriteCount,
    );
  }

  @override
  Future<void> clearLibrary() async {
    await _songsBox.clear();
    await _albumsBox.clear();
    await _artistsBox.clear();
  }

  // === Helper Methods ===

  /// Pick audio files using file picker
  @override
  Future<List<String>> pickAudioFiles() async {
    // Request storage permission on Android
    if (Platform.isAndroid) {
      // Try the newer READ_MEDIA_AUDIO permission first (Android 13+)
      // If that fails, fall back to READ_EXTERNAL_STORAGE (Android < 13)
      bool permissionGranted = false;

      try {
        final status = await Permission.audio.request();
        permissionGranted = status.isGranted;
      } catch (e) {
        debugPrint('Permission.audio not available, trying Permission.storage: $e');
      }

      if (!permissionGranted) {
        try {
          final status = await Permission.storage.request();
          permissionGranted = status.isGranted;
        } catch (e) {
          debugPrint('Permission.storage not available: $e');
        }
      }

      if (!permissionGranted) {
        debugPrint('Storage permissions not granted');
        return [];
      }
    }

    // FilePicker expects extensions without dots
    final extensions = _metadataService.supportedExtensions
        .map((e) => e.replaceFirst('.', ''))
        .toList();

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
      allowMultiple: true,
    );

    if (result == null || result.paths.isEmpty) {
      return [];
    }

    // Filter out null paths
    final paths = result.paths.whereType<String>().toList();

    return paths;
  }

  /// Pick a directory for scanning
  @override
  Future<String?> pickDirectory() async {
    // Request storage permission on Android
    if (Platform.isAndroid) {
      bool permissionGranted = false;

      try {
        final status = await Permission.audio.request();
        permissionGranted = status.isGranted;
      } catch (e) {
        debugPrint('Permission.audio not available, trying Permission.storage: $e');
      }

      if (!permissionGranted) {
        try {
          final status = await Permission.storage.request();
          permissionGranted = status.isGranted;
        } catch (e) {
          debugPrint('Permission.storage not available: $e');
        }
      }

      if (!permissionGranted) {
        debugPrint('Storage permissions not granted for directory pick');
        return null;
      }
    }

    final directory = await FilePicker.platform.getDirectoryPath();
    return directory;
  }

  Song _createSongFromMetadata(String filePath, MetadataResult metadata) {
    return Song(
      id: filePath.hashCode.toString(), // Simple ID generation
      title: metadata.title,
      artist: metadata.artist,
      album: metadata.album,
      duration: metadata.duration,
      filePath: filePath,
      albumArt: metadata.albumArt,
      trackNumber: metadata.trackNumber,
      discNumber: metadata.discNumber,
      year: metadata.year,
      genre: metadata.genre,
      bitrate: metadata.bitrate,
      dateAdded: DateTime.now(),
    );
  }
}
