import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';

import '../models/song_model.dart';

/// Audio background task handler for Android/iOS background playback
///
/// NOTE: On Linux, background audio service is not needed since media_kit
/// handles audio playback directly. This is only used for mobile platforms.
class AudioBackgroundTask {
  /// Global reference to the active audio handler
  static AudioPlayerHandler? _handler;

  /// Get the current audio handler
  static AudioPlayerHandler? get currentHandler => _handler;

  /// Start the audio service (only on mobile platforms)
  static Future<void> start() async {
    // Skip background service on Linux
    if (Platform.isLinux) {
      return;
    }

    try {
      // Add timeout to prevent hanging
      _handler = await AudioService.init(
        builder: AudioPlayerHandler.new,
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'top.immiq.echo_music.channel.audio',
          androidNotificationChannelName: 'Echo Music',
          androidNotificationOngoing: true,
        ),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint('AudioService.init timed out after 5 seconds, continuing without audio service');
          // Return null handler on timeout - app will continue without background service
          return AudioPlayerHandler();
        },
      );
    } catch (e) {
      debugPrint('AudioService.init failed: $e');
      // Don't rethrow - allow app to start even if audio service fails
    }
  }

  /// Set media item from song
  static MediaItem mediaItemFromSong(Song song) {
    return MediaItem(
      id: song.id,
      title: song.title,
      artist: song.artist,
      album: song.album,
      artUri: song.albumArt != null ? Uri.file(song.albumArt!.path) : null,
      duration: song.duration,
      displayTitle: song.title,
      displaySubtitle: song.artist,
      displayDescription: 'From ${song.album}',
    );
  }
}

/// Audio player handler for audio_service (mobile only)
///
/// This is a minimal implementation for mobile platforms.
/// On Linux, media_kit handles audio playback directly.
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  AudioPlayerHandler();

  // NOTE: This is a placeholder for mobile background support.
  // The actual playback is handled by media_kit in AudioServiceImpl.
  // For proper mobile background audio with media_kit, additional
  // integration work is needed using platform-specific APIs.

  @override
  Future<void> play() async {
    // Playback is handled by media_kit player in AudioServiceImpl
  }

  @override
  Future<void> pause() async {
    // Playback is handled by media_kit player in AudioServiceImpl
  }

  @override
  Future<void> stop() async {
    // Playback is handled by media_kit player in AudioServiceImpl
  }

  @override
  Future<void> seek(Duration position) async {
    // Playback is handled by media_kit player in AudioServiceImpl
  }

  @override
  Future<void> skipToNext() async {
    // Playback is handled by media_kit player in AudioServiceImpl
  }

  @override
  Future<void> skipToPrevious() async {
    // Playback is handled by media_kit player in AudioServiceImpl
  }
}
