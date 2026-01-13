import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';

/// Audio background task handler for Android/IiOS background playback
class AudioBackgroundTask {
  /// Global reference to the active audio handler
  static AudioPlayerHandler? _handler;

  /// Get the current audio handler
  static AudioPlayerHandler? get currentHandler => _handler;

  /// Start the audio service
  static Future<void> start() async {
    _handler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'top.immiq.echo_music.channel.audio',
        androidNotificationChannelName: 'Echo Music',
        androidNotificationOngoing: true,
        androidShowNotificationBadge: false,
        androidNotificationIcon: 'mipmap/ic_launcher',
        androidStopForegroundOnPause: true,
      ),
    );
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

/// Audio player handler for audio_service
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler() {
    _initListeners();
  }

  void _initListeners() {
    // Broadcast playback state changes
    _player.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        controls: _getControls(event.processingState),
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_player.loopMode] ?? AudioServiceRepeatMode.none,
        shuffleMode: (_player.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: _player.playing,
      ));
    });

    // Propagate media item changes
    _player.sequenceStream.listen((sequence) {
      if (sequence != null && sequence.isNotEmpty) {
        final currentIndex = _player.currentIndex;
        if (currentIndex != null && currentIndex >= 0) {
          final source = sequence[currentIndex];
          if (source.tag != null) {
            mediaItem.add(source.tag as MediaItem);
          }
        }
      }
    });
  }

  List<MediaControl> _getControls(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return [];
      case ProcessingState.ready:
      case ProcessingState.completed:
        return const [
          MediaControl.rewind,
          MediaControl.play,
          MediaControl.pause,
          MediaControl.stop,
          MediaControl.fastForward,
        ];
    }
  }

  @override
  Future<void> prepare() async {
    // Not implemented for now
  }

  Future<void> prepareFromMediaItem(MediaItem mediaItem) async {
    // Not implemented for now
  }

  @override
  Future<void> play() async {
    _player.play();
  }

  @override
  Future<void> pause() async {
    _player.pause();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> playFromMediaItem(MediaItem mediaItem) async {
    // Convert MediaItem back to audio source
    // This would need to be implemented based on your data model
    await _player.setUrl(mediaItem.extras?['uri'] ?? mediaItem.id);
    await _player.play();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    // Implement queue navigation
    if (index >= 0) {
      await _player.seek(Duration.zero,
          index: index); // Note: seek with index is not available in just_audio
    }
  }

  @override
  Future<void> skipToNext() async {
    await _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await _player.seekToPrevious();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        await _player.setLoopMode(LoopMode.off);
      case AudioServiceRepeatMode.one:
        await _player.setLoopMode(LoopMode.one);
      case AudioServiceRepeatMode.all:
        await _player.setLoopMode(LoopMode.all);
      case AudioServiceRepeatMode.group:
        // UNIMPLEMENTED - see https://github.com/ryanheise/audio_service/issues/560
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.all) {
      await _player.setShuffleModeEnabled(true);
    } else {
      await _player.setShuffleModeEnabled(false);
    }
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'dispose':
        await _player.dispose();
        break;
      case 'setQueue':
        // Handle queue setting
        if (extras != null && extras['items'] is List) {
          final items = extras['items'] as List;
          // Convert items to audio sources
          final audioSources = items.map((item) {
            if (item is MediaItem) {
              return AudioSource.uri(
                Uri.parse(item.extras?['uri'] ?? item.id),
                tag: item,
              );
            }
            return null;
          }).whereType<AudioSource>().toList();

          await _player.setAudioSource(ConcatenatingAudioSource(
            children: audioSources,
          ));
        }
        break;
      case 'addToQueue':
        if (extras != null && extras['item'] is MediaItem) {
          final item = extras['item'] as MediaItem;
          await _player.setAudioSource(
            ConcatenatingAudioSource(
              children: [
                AudioSource.uri(
                  Uri.parse(item.extras?['uri'] ?? item.id),
                  tag: item,
                ),
              ],
            ),
          );
        }
        break;
    }
  }

  Future<void> setQueue(List<MediaItem> queue) async {
    final audioSources = queue.map((item) {
      return AudioSource.uri(
        Uri.parse(item.extras?['uri'] ?? item.id),
        tag: item,
      );
    }).toList();

    await _player.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
    );
  }

  @override
  Future<void> addQueueItem(MediaItem item) async {
    await _player.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(item.extras?['uri'] ?? item.id),
            tag: item,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> addQueueItems(List<MediaItem> items) async {
    final audioSources = items.map((item) {
      return AudioSource.uri(
        Uri.parse(item.extras?['uri'] ?? item.id),
        tag: item,
      );
    }).toList();

    await _player.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
    );
  }

  @override
  Future<void> removeQueueItem(MediaItem item) async {
    // Implementation depends on queue management
  }
}
