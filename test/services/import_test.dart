import 'dart:io';

import 'package:echo_music/data/models/album_model.dart';
import 'package:echo_music/data/models/artist_model.dart';
import 'package:echo_music/data/models/playlist_model.dart';
import 'package:echo_music/data/models/settings_model.dart';
import 'package:echo_music/data/models/song_model.dart';
import 'package:echo_music/data/services/library_service.dart';
import 'package:echo_music/data/services/library_service_impl.dart';
import 'package:echo_music/data/services/metadata_service.dart';
import 'package:echo_music/data/services/metadata_service_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;

void main() {
  // Initialize Hive with in-memory storage for testing
  setUpAll(() async {
    Hive.init('./test_hive');
    Hive
      ..registerAdapter(AlbumArtAdapter())
      ..registerAdapter(SongAdapter())
      ..registerAdapter(AlbumAdapter())
      ..registerAdapter(ArtistAdapter())
      ..registerAdapter(PlaylistAdapter())
      ..registerAdapter(AppSettingsAdapter());
  });

  group('Music Import Test', () {
    late MetadataService metadataService;
    late LibraryServiceImpl libraryService;

    setUp(() async {
      metadataService = MetadataServiceImpl();
      libraryService = LibraryServiceImpl(metadataService);
      await libraryService.init();
    });

    test('test OGG file metadata extraction', () async {
      const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

      // Check if file exists
      final file = File(testFile);
      debugPrint('File exists: ${file.existsSync()}');
      if (!file.existsSync()) {
        debugPrint('SKIP: Test file not found');
        return;
      }

      // Test if format is supported
      final isSupported = metadataService.isSupportedFormat(testFile);
      debugPrint('Is supported format: $isSupported');
      expect(isSupported, isTrue, reason: 'OGG file should be supported');

      // Test metadata extraction
      debugPrint('Extracting metadata...');
      final metadata = await metadataService.extractMetadata(testFile);

      debugPrint('Title: ${metadata.title}');
      debugPrint('Artist: ${metadata.artist}');
      debugPrint('Album: ${metadata.album}');
      debugPrint('Duration: ${metadata.duration}');
      debugPrint('Year: ${metadata.year}');
      debugPrint('Track: ${metadata.trackNumber}');
      debugPrint('Genre: ${metadata.genre}');

      expect(metadata.title, isNotEmpty);
      expect(metadata.artist, isNotEmpty);
      expect(metadata.album, isNotEmpty);
      expect(metadata.duration.inSeconds, greaterThan(0));
    });

    test('test import single OGG file', () async {
      const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

      // Check if file exists
      final file = File(testFile);
      if (!file.existsSync()) {
        debugPrint('SKIP: Test file not found');
        return;
      }

      debugPrint('Importing file: $testFile');

      // Try to get metadata first
      debugPrint('Step 1: Extract metadata');
      final metadata = await metadataService.extractMetadata(testFile);
      debugPrint('Metadata extracted: ${metadata.title}');

      // Try to create song
      debugPrint('Step 2: Create song object');
      final songId = testFile.hashCode.toString();
      debugPrint('Song ID: $songId');

      // Try to add song directly
      debugPrint('Step 3: Add song to library');
      try {
        final song = Song(
          id: songId,
          title: metadata.title,
          artist: metadata.artist,
          album: metadata.album,
          duration: metadata.duration,
          filePath: testFile,
          albumArt: metadata.albumArt,
          trackNumber: metadata.trackNumber,
          discNumber: metadata.discNumber,
          year: metadata.year,
          genre: metadata.genre,
          bitrate: metadata.bitrate,
          dateAdded: DateTime.now(),
        );
        await libraryService.addSong(song);
        debugPrint('Song added successfully');
      } catch (e) {
        debugPrint('Error adding song: $e');
        rethrow;
      }

      // Now try importFiles
      debugPrint('Step 4: Run importFiles');
      final songs = await libraryService.importFiles([testFile]);

      debugPrint('Imported ${songs.length} song(s)');

      expect(songs, isNotEmpty);
      expect(songs.length, greaterThan(0));

      final song = songs.first;
      debugPrint('Song ID: ${song.id}');
      debugPrint('Song title: ${song.title}');
      debugPrint('Song artist: ${song.artist}');
      debugPrint('Song album: ${song.album}');
      debugPrint('Song duration: ${song.duration}');
      debugPrint('Song filePath: ${song.filePath}');

      expect(song.title, isNotEmpty);
      expect(song.filePath, equals(testFile));
    });

    test('test get all songs after import', () async {
      const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

      // Check if file exists
      final file = File(testFile);
      if (!file.existsSync()) {
        debugPrint('SKIP: Test file not found');
        return;
      }

      // Clear library first
      await libraryService.clearLibrary();

      // Import file
      await libraryService.importFiles([testFile]);

      // Get all songs
      final allSongs = await libraryService.getAllSongs();

      debugPrint('Total songs in library: ${allSongs.length}');

      expect(allSongs, isNotEmpty);
      expect(allSongs.length, greaterThan(0));

      // Find our imported song
      final importedSong = allSongs.firstWhere(
        (s) => s.filePath == testFile,
        orElse: () => throw Exception('Imported song not found in library'),
      );

      debugPrint('Found imported song: ${importedSong.title}');
      expect(importedSong.title, isNotEmpty);
    });
  });
}
