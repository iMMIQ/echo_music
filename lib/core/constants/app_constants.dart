/// Application-wide constants
class AppConstants {
  const AppConstants._();

  // App info
  static const String appName = 'Echo Music';
  static const String appVersion = '1.0.0';

  // Default values
  static const int defaultScanBatchSize = 50;
  static const int defaultSearchHistoryLimit = 20;
  static const int defaultRecentlyPlayedLimit = 50;
  static const int defaultTopSongsCount = 25;

  // Playback
  static const int defaultCrossfadeDurationMs = 2000;
  static const double defaultPlaybackSpeed = 1;
  static const double minPlaybackSpeed = 0.5;
  static const double maxPlaybackSpeed = 2;

  // Cache
  static const int maxAlbumArtCacheSize = 100;
  static const int maxImageCacheSizeMb = 500;

  // Supported audio formats
  static const Set<String> supportedAudioFormats = {
    'mp3',
    'm4a',
    'aac',
    'flac',
    'wav',
    'ogg',
    'opus',
    'wma',
    'alac',
    'aiff',
  };

  // Supported artwork formats
  static const Set<String> supportedArtworkFormats = {
    'jpg',
    'jpeg',
    'png',
    'webp',
    'gif',
    'bmp',
  };

  // Playlist limits
  static const int maxPlaylistNameLength = 100;
  static const int maxSongsInSmartPlaylist = 1000;

  // Network
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  // File system
  static const int maxFileSizeBytes = 500 * 1024 * 1024; // 500MB

  // Animation durations (ms)
  static const int animationFast = 150;
  static const int animationNormal = 250;
  static const int animationSlow = 350;
  static const int animationSlower = 500;
}

/// Hive box names
class HiveBoxes {
  const HiveBoxes._();

  static const String songs = 'songs';
  static const String albums = 'albums';
  static const String artists = 'artists';
  static const String playlists = 'playlists';
  static const String playbackHistory = 'playback_history';
  static const String favorites = 'favorites';
  static const String settings = 'settings';
  static const String scanCache = 'scan_cache';
}

/// Shared preferences keys
class PrefsKeys {
  const PrefsKeys._();

  static const String themeMode = 'theme_mode';
  static const String accentColor = 'accent_color';
  static const String equalizerEnabled = 'equalizer_enabled';
  static const String equalizerPreset = 'equalizer_preset';
  static const String crossfadeEnabled = 'crossfade_enabled';
  static const String crossfadeDuration = 'crossfade_duration';
  static const String scanDirectories = 'scan_directories';
  static const String autoScan = 'auto_scan';
  static const String playbackSpeed = 'playback_speed';
  static const String navidromeUrl = 'navidrome_url';
  static const String navidromeUsername = 'navidrome_username';
  static const String lastScanTime = 'last_scan_time';
}
