import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'settings_model.freezed.dart';

/// App settings model
@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    /// Theme mode (light, dark, system)
    @Default(ThemeMode.system) @HiveField(0) ThemeMode themeMode,

    /// Accent color index
    @Default(0) @HiveField(1) int accentColorIndex,

    /// Audio quality (low, medium, high)
    @Default(AudioQuality.high) @HiveField(2) AudioQuality audioQuality,

    /// Crossfade duration in seconds (0 = disabled)
    @Default(0) @HiveField(3) int crossfadeDuration,

    /// Auto-refresh library on app start
    @Default(true) @HiveField(4) bool autoRefreshOnStart,

    /// Music folders for library scanning
    @Default([]) @HiveField(5) List<String> musicFolders,
  }) = _AppSettings;

  const AppSettings._();
}

/// Audio quality options
enum AudioQuality {
  low('Low', 128),
  medium('Medium', 256),
  high('High', 320);

  const AudioQuality(this.label, this.bitrate);

  final String label;
  final int bitrate;
}

/// Extension for Hive adapter
class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  int get typeId => 6;

  @override
  AppSettings read(BinaryReader reader) {
    final themeModeIndex = reader.read();
    final accentColorIndex = reader.read();
    final audioQualityIndex = reader.read();
    final crossfadeDuration = reader.read();
    final autoRefreshOnStart = reader.read();
    final musicFolders = reader.read();

    return AppSettings(
      themeMode: ThemeMode.values[themeModeIndex as int],
      accentColorIndex: accentColorIndex as int,
      audioQuality: AudioQuality.values[audioQualityIndex as int],
      crossfadeDuration: crossfadeDuration as int,
      autoRefreshOnStart: autoRefreshOnStart as bool,
      musicFolders: (musicFolders as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..write(obj.themeMode.index)
      ..write(obj.accentColorIndex)
      ..write(obj.audioQuality.index)
      ..write(obj.crossfadeDuration)
      ..write(obj.autoRefreshOnStart)
      ..write(obj.musicFolders);
  }
}

/// Available accent colors
class AccentColors {
  static const List<Color> colors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
    Color(0xFFEF4444), // Red
    Color(0xFFF59E0B), // Amber
    Color(0xFF10B981), // Green
    Color(0xFF06B6D4), // Cyan
    Color(0xFF3B82F6), // Blue
  ];

  static const List<String> names = [
    'Indigo',
    'Violet',
    'Pink',
    'Red',
    'Amber',
    'Green',
    'Cyan',
    'Blue',
  ];
}
