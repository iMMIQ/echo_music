import 'dart:io';

import 'package:hive/hive.dart';
import 'package:echo_music/data/models/album_model.dart';
import 'package:echo_music/data/models/artist_model.dart';
import 'package:echo_music/data/models/playlist_model.dart';
import 'package:echo_music/data/models/song_model.dart';
import 'package:echo_music/data/models/settings_model.dart';
import 'package:echo_music/data/services/library_service.dart';
import 'package:echo_music/data/services/library_service_impl.dart';
import 'package:echo_music/data/services/metadata_service.dart';
import 'package:echo_music/data/services/metadata_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  // Initialize Hive with in-memory storage for testing
  setUpAll(() async {
    Hive.init('./test_hive');
    Hive.registerAdapter(AlbumArtAdapter());
    Hive.registerAdapter(SongAdapter());
    Hive.registerAdapter(AlbumAdapter());
    Hive.registerAdapter(ArtistAdapter());
    Hive.registerAdapter(PlaylistAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
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
      print('File exists: ${file.existsSync()}');
      if (!file.existsSync()) {
        print('SKIP: Test file not found');
        return;
      }

      // Test if format is supported
      final isSupported = metadataService.isSupportedFormat(testFile);
      print('Is supported format: $isSupported');
      expect(isSupported, isTrue, reason: 'OGG file should be supported');

      // Test metadata extraction
      print('Extracting metadata...');
      final metadata = await metadataService.extractMetadata(testFile);

      print('Title: ${metadata.title}');
      print('Artist: ${metadata.artist}');
      print('Album: ${metadata.album}');
      print('Duration: ${metadata.duration}');
      print('Year: ${metadata.year}');
      print('Track: ${metadata.trackNumber}');
      print('Genre: ${metadata.genre}');

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
        print('SKIP: Test file not found');
        return;
      }

      print('Importing file: $testFile');

      // Try to get metadata first
      print('Step 1: Extract metadata');
      final metadata = await metadataService.extractMetadata(testFile);
      print('Metadata extracted: ${metadata.title}');

      // Try to create song
      print('Step 2: Create song object');
      final songId = testFile.hashCode.toString();
      print('Song ID: $songId');

      // Try to add song directly
      print('Step 3: Add song to library');
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
        print('Song added successfully');
      } catch (e) {
        print('Error adding song: $e');
        rethrow;
      }

      // Now try importFiles
      print('Step 4: Run importFiles');
      final songs = await libraryService.importFiles([testFile]);

      print('Imported ${songs.length} song(s)');

      expect(songs, isNotEmpty);
      expect(songs.length, greaterThan(0));

      final song = songs.first;
      print('Song ID: ${song.id}');
      print('Song title: ${song.title}');
      print('Song artist: ${song.artist}');
      print('Song album: ${song.album}');
      print('Song duration: ${song.duration}');
      print('Song filePath: ${song.filePath}');

      expect(song.title, isNotEmpty);
      expect(song.filePath, equals(testFile));
    });

    test('test get all songs after import', () async {
      const testFile = '/home/ayd/音乐/iroha _ 镜音铃 (鏡音リン) - 炉心融解.ogg';

      // Check if file exists
      final file = File(testFile);
      if (!file.existsSync()) {
        print('SKIP: Test file not found');
        return;
      }

      // Clear library first
      await libraryService.clearLibrary();

      // Import file
      await libraryService.importFiles([testFile]);

      // Get all songs
      final allSongs = await libraryService.getAllSongs();

      print('Total songs in library: ${allSongs.length}');

      expect(allSongs, isNotEmpty);
      expect(allSongs.length, greaterThan(0));

      // Find our imported song
      final importedSong = allSongs.firstWhere(
        (s) => s.filePath == testFile,
        orElse: () => throw Exception('Imported song not found in library'),
      );

      print('Found imported song: ${importedSong.title}');
      expect(importedSong.title, isNotEmpty);
    });
  });
}
