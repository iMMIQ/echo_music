// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioServiceHash() => r'ab060eac90d6b2940d2a8cec99411a64abb92fbc';

/// Audio service provider
///
/// Copied from [audioService].
@ProviderFor(audioService)
final audioServiceProvider = AutoDisposeProvider<AudioService>.internal(
  audioService,
  name: r'audioServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioServiceRef = AutoDisposeProviderRef<AudioService>;
String _$playbackStateHash() => r'ef1e2750702a82b4ed340a4195289cdc277159cc';

/// Playback state stream provider
///
/// Copied from [playbackState].
@ProviderFor(playbackState)
final playbackStateProvider = AutoDisposeStreamProvider<PlaybackState>.internal(
  playbackState,
  name: r'playbackStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playbackStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlaybackStateRef = AutoDisposeStreamProviderRef<PlaybackState>;
String _$playbackPositionHash() => r'b5acb77f7db1ef536ea7f6e723378b49fc09d217';

/// Position stream provider
///
/// Copied from [playbackPosition].
@ProviderFor(playbackPosition)
final playbackPositionProvider = AutoDisposeStreamProvider<Duration>.internal(
  playbackPosition,
  name: r'playbackPositionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playbackPositionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlaybackPositionRef = AutoDisposeStreamProviderRef<Duration>;
String _$playbackDurationHash() => r'3552fd9d2265b8766679a91abcc845169ef1fe4e';

/// Duration stream provider
///
/// Copied from [playbackDuration].
@ProviderFor(playbackDuration)
final playbackDurationProvider = AutoDisposeStreamProvider<Duration>.internal(
  playbackDuration,
  name: r'playbackDurationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playbackDurationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlaybackDurationRef = AutoDisposeStreamProviderRef<Duration>;
String _$isPlayingHash() => r'a7d7d91cf1570a43aea0a81f39bb5848865abe09';

/// Playing state stream provider
///
/// Copied from [isPlaying].
@ProviderFor(isPlaying)
final isPlayingProvider = AutoDisposeStreamProvider<bool>.internal(
  isPlaying,
  name: r'isPlayingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isPlayingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsPlayingRef = AutoDisposeStreamProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
