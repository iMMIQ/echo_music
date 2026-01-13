import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/settings_model.dart';
import '../../data/services/settings_service.dart';

part 'settings_provider.g.dart';

/// Settings provider
@riverpod
class Settings extends _$Settings {
  @override
  AppSettings build() {
    return SettingsService.current;
  }

  /// Update theme mode
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await SettingsService.setThemeMode(themeMode);
    state = SettingsService.current;
  }

  /// Update accent color
  Future<void> setAccentColor(int index) async {
    await SettingsService.setAccentColor(index);
    state = SettingsService.current;
  }

  /// Update audio quality
  Future<void> setAudioQuality(AudioQuality quality) async {
    await SettingsService.setAudioQuality(quality);
    state = SettingsService.current;
  }

  /// Update crossfade duration
  Future<void> setCrossfadeDuration(int duration) async {
    await SettingsService.setCrossfadeDuration(duration);
    state = SettingsService.current;
  }

  /// Update auto-refresh on start
  Future<void> setAutoRefreshOnStart(bool value) async {
    await SettingsService.setAutoRefreshOnStart(value);
    state = SettingsService.current;
  }

  /// Add music folder
  Future<void> addMusicFolder(String path) async {
    await SettingsService.addMusicFolder(path);
    state = SettingsService.current;
  }

  /// Remove music folder
  Future<void> removeMusicFolder(String path) async {
    await SettingsService.removeMusicFolder(path);
    state = SettingsService.current;
  }

  /// Reset to defaults
  Future<void> resetToDefaults() async {
    await SettingsService.resetToDefaults();
    state = SettingsService.current;
  }
}

/// Current theme mode provider
@riverpod
ThemeMode currentThemeMode(CurrentThemeModeRef ref) {
  return ref.watch(settingsProvider).themeMode;
}

/// Current accent color provider
@riverpod
Color currentAccentColor(CurrentAccentColorRef ref) {
  final index = ref.watch(settingsProvider).accentColorIndex;
  return AccentColors.colors[index];
}
