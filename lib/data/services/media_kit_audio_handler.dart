import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';

/// Audio player handler for audio_service using media_kit
///
/// Integrates media_kit with audio_service for background playback on mobile
class MediaKitAudioHandler extends BaseAudioHandler with SeekHandler {
  MediaKitAudioHandler() {
    _init();
  }

  late final Player player = Player();

  final List<MediaItem> _internalQueue = [];

  Future<void> _init() async {
    // Broadcast the current queue
    player.stream.playing.listen((playing) {
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        playing: playing,
        updatePosition: player.state.position,
      ));
    });

    // Broadcast position changes
    player.stream.position.listen((position) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: position,
      ));
    });

    // Broadcast speed changes
    player.stream.rate.listen((rate) {
      playbackState.add(playbackState.value.copyWith(speed: rate));
    });

    debugPrint('MediaKitAudioHandler: Initialized with media_kit');
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> stop() async {
    await player.stop();
  }

  @override
  Future<void> skipToNext() => player.next();

  @override
  Future<void> skipToPrevious() => player.previous();

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));

    final playlistMode = switch (repeatMode) {
      AudioServiceRepeatMode.one => PlaylistMode.single,
      AudioServiceRepeatMode.all => PlaylistMode.loop,
      AudioServiceRepeatMode.none => PlaylistMode.single,
      AudioServiceRepeatMode.group => PlaylistMode.single,
    };

    await player.setPlaylistMode(playlistMode);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    await player.setShuffle(enabled);
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
  }

  @override
  Future<void> setSpeed(double speed) async {
    await player.setRate(speed);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    _internalQueue.add(mediaItem);
    queue.add([..._internalQueue]);
    await _updatePlaylist();
    debugPrint('MediaKitAudioHandler: addQueueItem: ${mediaItem.title}');
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    _internalQueue.addAll(mediaItems);
    queue.add([..._internalQueue]);
    await _updatePlaylist();
    debugPrint('MediaKitAudioHandler: addQueueItems: ${mediaItems.length} items');
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    _internalQueue
      ..clear()
      ..addAll(queue);
    this.queue.add([..._internalQueue]);
    await _updatePlaylist();
  }

  /// Updates the media_kit playlist from the internal queue
  Future<void> _updatePlaylist() async {
    if (_internalQueue.isEmpty) return;

    final medias = _internalQueue.map((item) {
      // Support both file paths and URIs
      final uri = item.id.startsWith('file://')
          ? item.id
          : (item.id.startsWith('/') || item.id.contains(':'))
              ? 'file://$item.id'
              : item.id;
      return Media(uri);
    }).toList();

    try {
      final wasPlaying = player.state.playing;
      final currentPosition = player.state.position;

      await player.open(
        Playlist(medias),
        play: wasPlaying,
      );

      if (currentPosition > Duration.zero) {
        await player.seek(currentPosition);
      }
    } catch (e) {
      debugPrint('MediaKitAudioHandler: Error updating playlist: $e');
    }
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    _internalQueue.removeWhere((item) => item.id == mediaItem.id);
    queue.add([..._internalQueue]);
    await _updatePlaylist();
  }

  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    if (currentIndex < 0 ||
        currentIndex >= _internalQueue.length ||
        newIndex < 0 ||
        newIndex >= _internalQueue.length) {
      return;
    }

    final item = _internalQueue.removeAt(currentIndex);
    _internalQueue.insert(newIndex, item);
    queue.add([..._internalQueue]);
    await _updatePlaylist();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    await player.jump(index);
  }

  Future<void> dispose() async {
    await player.dispose();
  }
}
