import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/settings_model.dart';
import 'hive_service.dart';

/// Settings service for managing app settings
class SettingsService {
  /// Get the settings box
  static Box<AppSettings> get _box =>
      HiveService.getBox<AppSettings>(HiveBoxes.settings);

  /// Get current settings
  static AppSettings get current {
    return _box.get('current', defaultValue: _defaultSettings)!;
  }

  /// Default settings
  static const AppSettings _defaultSettings = AppSettings();

  /// Save settings
  static Future<void> save(AppSettings settings) async {
    await _box.put('current', settings);
  }

  /// Update theme mode
  static Future<void> setThemeMode(ThemeMode themeMode) async {
    final current = SettingsService.current;
    await save(current.copyWith(themeMode: themeMode));
  }

  /// Update accent color
  static Future<void> setAccentColor(int index) async {
    final current = SettingsService.current;
    await save(current.copyWith(accentColorIndex: index));
  }

  /// Update audio quality
  static Future<void> setAudioQuality(AudioQuality quality) async {
    final current = SettingsService.current;
    await save(current.copyWith(audioQuality: quality));
  }

  /// Update crossfade duration
  static Future<void> setCrossfadeDuration(int duration) async {
    final current = SettingsService.current;
    await save(current.copyWith(crossfadeDuration: duration));
  }

  /// Update auto-refresh on start
  static Future<void> setAutoRefreshOnStart(bool value) async {
    final current = SettingsService.current;
    await save(current.copyWith(autoRefreshOnStart: value));
  }

  /// Add music folder
  static Future<void> addMusicFolder(String path) async {
    final current = SettingsService.current;
    final folders = List<String>.from(current.musicFolders);
    if (!folders.contains(path)) {
      folders.add(path);
      await save(current.copyWith(musicFolders: folders));
    }
  }

  /// Remove music folder
  static Future<void> removeMusicFolder(String path) async {
    final current = SettingsService.current;
    final folders = List<String>.from(current.musicFolders);
    folders.remove(path);
    await save(current.copyWith(musicFolders: folders));
  }

  /// Clear all settings (reset to defaults)
  static Future<void> resetToDefaults() async {
    await save(_defaultSettings);
  }
}
