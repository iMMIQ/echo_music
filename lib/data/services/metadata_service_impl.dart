import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:metadata_god/metadata_god.dart';
import 'metadata_service.dart';
import '../models/song_model.dart';

/// Metadata service implementation using metadata_god
class MetadataServiceImpl extends MetadataService {
  static const _supportedExtensions = [
    '.mp3',
    '.m4a',
    '.flac',
    '.wav',
    '.ogg',
    '.opus',
    '.wma',
    '.aac',
  ];

  @override
  Future<MetadataResult> extractMetadata(String filePath) async {
    try {
      final metadata = await MetadataGod.readMetadata(file: filePath);

      // Extract duration (handle both int and double)
      Duration duration = Duration.zero;
      if (metadata.durationMs != null) {
        final ms = metadata.durationMs is double
            ? (metadata.durationMs as double).toInt()
            : metadata.durationMs as int;
        duration = Duration(milliseconds: ms);
      } else {
        duration = await _getDurationFromFile(filePath);
      }

      return MetadataResult(
        title: metadata.title ?? _getFileName(filePath),
        artist: metadata.artist ?? 'Unknown Artist',
        album: metadata.album ?? 'Unknown Album',
        year: metadata.year,
        trackNumber: metadata.trackNumber,
        discNumber: metadata.discNumber,
        genre: metadata.genre,
        bitrate: null,
        duration: duration,
        albumArt: null, // TODO: Extract album art when API is stable
      );
    } catch (e) {
      // Return basic metadata if extraction fails
      return MetadataResult(
        title: _getFileName(filePath),
        artist: 'Unknown Artist',
        album: 'Unknown Album',
        duration: await _getDurationFromFile(filePath),
        albumArt: null,
      );
    }
  }

  @override
  Future<List<MetadataResult>> extractMultiple(List<String> filePaths) async {
    final results = <MetadataResult>[];
    for (final filePath in filePaths) {
      try {
        final metadata = await extractMetadata(filePath);
        results.add(metadata);
      } catch (e) {
        // Skip files that fail to extract
        continue;
      }
    }
    return results;
  }

  @override
  Future<AlbumArt?> extractAlbumArt(String filePath) async {
    // TODO: Implement album art extraction when API is stable
    return null;
  }

  @override
  Future<Duration> getDuration(String filePath) async {
    try {
      final metadata = await MetadataGod.readMetadata(file: filePath);
      if (metadata.durationMs != null) {
        final ms = metadata.durationMs is double
            ? (metadata.durationMs as double).toInt()
            : metadata.durationMs as int;
        return Duration(milliseconds: ms);
      }
    } catch (e) {
      // Fall through to file-based duration
    }
    return await _getDurationFromFile(filePath);
  }

  @override
  Future<AudioFormatInfo> getFormatInfo(String filePath) async {
    try {
      final metadata = await MetadataGod.readMetadata(file: filePath);
      final extension = path.extension(filePath).replaceFirst('.', '');
      final duration = metadata.durationMs != null
          ? Duration(
              milliseconds: metadata.durationMs is double
                  ? (metadata.durationMs as double).toInt()
                  : metadata.durationMs as int,
            )
          : await _getDurationFromFile(filePath);

      return AudioFormatInfo(
        format: extension,
        mimeType: _getMimeType(extension),
        bitrate: null,
        sampleRate: null,
        channels: null,
        bitsPerSample: null,
        duration: duration,
      );
    } catch (e) {
      final extension = path.extension(filePath).replaceFirst('.', '');
      return AudioFormatInfo(
        format: extension,
        mimeType: _getMimeType(extension),
        duration: await _getDurationFromFile(filePath),
      );
    }
  }

  @override
  bool isSupportedFormat(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    return _supportedExtensions.contains(extension);
  }

  @override
  List<String> get supportedExtensions => _supportedExtensions;

  @override
  Future<String> saveAlbumArt(AlbumArt albumArt, String directory) async {
    // TODO: Implement saving album art to a file
    // For now, return the original path
    return albumArt.path;
  }

  // === Private Methods ===

  String _getFileName(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }

  Future<Duration> _getDurationFromFile(String filePath) async {
    // This is a fallback method. In a real implementation,
    // you might use just_audio or another audio library to get the duration.
    // For now, return a default duration.
    return Duration.zero;
  }

  String? _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'mp3':
        return 'audio/mpeg';
      case 'm4a':
      case 'aac':
        return 'audio/mp4';
      case 'flac':
        return 'audio/flac';
      case 'wav':
        return 'audio/wav';
      case 'ogg':
      case 'opus':
        return 'audio/ogg';
      case 'wma':
        return 'audio/x-ms-wma';
      default:
        return null;
    }
  }
}
