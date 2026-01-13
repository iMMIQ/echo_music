import '../models/song_model.dart';

/// Metadata extraction result
class MetadataResult {
  const MetadataResult({
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    this.year,
    this.trackNumber,
    this.discNumber,
    this.genre,
    this.bitrate,
    this.albumArt,
  });
  final String title;
  final String artist;
  final String album;
  final int? year;
  final int? trackNumber;
  final int? discNumber;
  final String? genre;
  final int? bitrate;
  final Duration duration;
  final AlbumArt? albumArt;
}

/// Metadata service interface for extracting audio metadata
abstract class MetadataService {
  /// Extract metadata from audio file
  Future<MetadataResult> extractMetadata(String filePath);

  /// Extract metadata from multiple files
  Future<List<MetadataResult>> extractMultiple(List<String> filePaths);

  /// Extract album art from audio file
  Future<AlbumArt?> extractAlbumArt(String filePath);

  /// Get audio file duration
  Future<Duration> getDuration(String filePath);

  /// Get audio file format info
  Future<AudioFormatInfo> getFormatInfo(String filePath);

  /// Check if file is supported audio format
  bool isSupportedFormat(String filePath);

  /// Get supported file extensions
  List<String> get supportedExtensions;

  /// Save album art to file
  Future<String> saveAlbumArt(AlbumArt albumArt, String directory);
}

/// Audio format information
class AudioFormatInfo {
  const AudioFormatInfo({
    required this.format,
    required this.duration,
    this.mimeType,
    this.bitrate,
    this.sampleRate,
    this.channels,
    this.bitsPerSample,
  });
  final String format;
  final String? mimeType;
  final int? bitrate;
  final int? sampleRate;
  final int? channels;
  final int? bitsPerSample;
  final Duration duration;

  /// Get human readable format
  String get formatLabel {
    switch (format.toUpperCase()) {
      case 'MP3':
        return 'MP3';
      case 'FLAC':
        return 'FLAC';
      case 'M4A':
        return 'AAC';
      case 'OGG':
        return 'OGG Vorbis';
      case 'WAV':
        return 'WAV';
      case 'OPUS':
        return 'Opus';
      default:
        return format.toUpperCase();
    }
  }

  /// Get quality label
  String get qualityLabel {
    if (bitrate == null) return 'Unknown';

    final kbps = bitrate! ~/ 1000;
    if (kbps >= 320) return 'High ($kbps kbps)';
    if (kbps >= 256) return 'Good ($kbps kbps)';
    if (kbps >= 192) return 'Standard ($kbps kbps)';
    if (kbps >= 128) return 'Normal ($kbps kbps)';
    return 'Low ($kbps kbps)';
  }
}
