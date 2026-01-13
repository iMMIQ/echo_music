// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentThemeModeHash() => r'3ee04d532627a13df3363fcbfbd52362df5f0ffc';

/// Current theme mode provider
///
/// Copied from [currentThemeMode].
@ProviderFor(currentThemeMode)
final currentThemeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  currentThemeMode,
  name: r'currentThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$currentAccentColorHash() =>
    r'7e29b12f3cf0d050488dfea14903ce2c3a48dfa3';

/// Current accent color provider
///
/// Copied from [currentAccentColor].
@ProviderFor(currentAccentColor)
final currentAccentColorProvider = AutoDisposeProvider<Color>.internal(
  currentAccentColor,
  name: r'currentAccentColorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentAccentColorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentAccentColorRef = AutoDisposeProviderRef<Color>;
String _$settingsHash() => r'70c4f3150d6539e87617c4e08b8b0aa40e63b9f7';

/// Settings provider
///
/// Copied from [Settings].
@ProviderFor(Settings)
final settingsProvider =
    AutoDisposeNotifierProvider<Settings, AppSettings>.internal(
  Settings.new,
  name: r'settingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Settings = AutoDisposeNotifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
