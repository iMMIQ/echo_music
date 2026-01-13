import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/song_model.dart';

part 'audio_service.freezed.dart';

/// Playback state
@freezed
class PlaybackState with _$PlaybackState {
  const factory PlaybackState({
    required bool isPlaying,
    required Song? currentSong,
    required Duration position,
    required Duration duration,
    required double playbackSpeed,
    required List<Song> queue,
    required int currentIndex,
    @Default(RepeatMode.off) RepeatMode repeatMode,
    @Default(false) bool isShuffle,
  }) = _PlaybackState;

  /// Initial state
  factory PlaybackState.initial() => const PlaybackState(
    isPlaying: false,
    currentSong: null,
    position: Duration.zero,
    duration: Duration.zero,
    playbackSpeed: 1,
    queue: [],
    currentIndex: -1,
  );
}

/// Repeat mode
enum RepeatMode { off, all, one }

/// Audio service interface for playback control
abstract class AudioService {
  /// Stream of playback state changes
  Stream<PlaybackState> get playbackStateStream;

  /// Stream of position changes
  Stream<Duration> get positionStream;

  /// Stream of duration changes
  Stream<Duration> get durationStream;

  /// Stream of playing state changes
  Stream<bool> get playingStream;

  /// Current playback state
  PlaybackState get currentState;

  /// Current position
  Duration get position;

  /// Current duration
  Duration get duration;

  /// Is playing
  bool get isPlaying;

  /// Play a song
  Future<void> play(Song song);

  /// Pause playback
  Future<void> pause();

  /// Stop playback
  Future<void> stop();

  /// Seek to position
  Future<void> seek(Duration position);

  /// Skip to next track
  Future<void> skipToNext();

  /// Skip to previous track
  Future<void> skipToPrevious();

  /// Set playback speed (0.5 - 2.0)
  Future<void> setSpeed(double speed);

  /// Set repeat mode
  Future<void> setRepeatMode(RepeatMode mode);

  /// Toggle shuffle
  Future<void> toggleShuffle(bool enabled);

  /// Set queue
  Future<void> setQueue(List<Song> songs, {int startIndex = 0});

  /// Add to queue
  Future<void> addToQueue(Song song);

  /// Add multiple songs to queue
  Future<void> addToQueueNext(List<Song> songs);

  /// Remove from queue
  Future<void> removeFromQueue(int index);

  /// Move queue item
  Future<void> moveQueueItem(int oldIndex, int newIndex);

  /// Clear queue
  Future<void> clearQueue();

  /// Dispose resources
  Future<void> dispose();
}
