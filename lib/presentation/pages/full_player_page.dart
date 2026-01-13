import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../providers/audio_provider.dart';
import '../../data/services/audio_service.dart';

/// Full-screen music player page
class FullPlayerPage extends ConsumerStatefulWidget {
  const FullPlayerPage({super.key});

  @override
  ConsumerState<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends ConsumerState<FullPlayerPage> {
  double _sliderValue = 0.0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Album art
                    _AlbumArt(),

                    const SizedBox(height: 48),

                    // Song info
                    _SongInfo(),

                    const SizedBox(height: 32),

                    // Progress bar
                    _ProgressBar(),

                    const SizedBox(height: 32),

                    // Main controls
                    _MainControls(),

                    const SizedBox(height: 32),

                    // Secondary controls
                    _SecondaryControls(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          IconButton(
            icon: Icon(
              PhosphorIcons.caretDown(),
              size: 32,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),

          // "Now Playing" label
          Text(
            'Now Playing',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          // More options
          IconButton(
            icon: Icon(
              PhosphorIcons.dotsThree(),
              size: 24,
            ),
            onPressed: () {
              // Show more options menu
            },
          ),
        ],
      ),
    );
  }
}

/// Album art widget
class _AlbumArt extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateAsync = ref.watch(playbackStateProvider);

    return playbackStateAsync.when(
      data: (state) {
        final song = state.currentSong;

        if (song == null) {
          return const SizedBox.shrink();
        }

        return Container(
          width: 256,
          height: 256,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: song.albumArt != null
                ? Image.file(
                    File(song.albumArt!.path),
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Icon(
                      PhosphorIcons.musicNote(),
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

/// Song info widget
class _SongInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateAsync = ref.watch(playbackStateProvider);

    return playbackStateAsync.when(
      data: (state) {
        final song = state.currentSong;

        if (song == null) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            Text(
              song.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              song.artist,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              song.album,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

/// Progress bar widget
class _ProgressBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends ConsumerState<_ProgressBar> {
  double _sliderValue = 0.0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final playbackStateAsync = ref.watch(playbackStateProvider);

    return playbackStateAsync.when(
      data: (state) {
        final song = state.currentSong;

        if (song == null) {
          return const SizedBox.shrink();
        }

        final position = _isDragging
            ? Duration(milliseconds: (_sliderValue * state.duration.inMilliseconds).round())
            : state.position;
        final progress = state.duration.inMilliseconds > 0
            ? position.inMilliseconds / state.duration.inMilliseconds
            : 0.0;

        if (!_isDragging) {
          _sliderValue = progress;
        }

        return Column(
          children: [
            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                thumbColor: Theme.of(context).colorScheme.primary,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                trackHeight: 4,
              ),
              child: Slider(
                value: _sliderValue.clamp(0.0, 1.0),
                onChanged: (value) {
                  setState(() {
                    _isDragging = true;
                    _sliderValue = value;
                  });
                },
                onChangeEnd: (value) {
                  final newPosition = Duration(
                    milliseconds: (value * state.duration.inMilliseconds).round(),
                  );
                  ref.read(audioServiceProvider).seek(newPosition);
                  setState(() {
                    _isDragging = false;
                  });
                },
              ),
            ),

            // Time labels
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(position),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                  ),
                  Text(
                    _formatDuration(state.duration),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

/// Main controls widget
class _MainControls extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateAsync = ref.watch(playbackStateProvider);

    return playbackStateAsync.when(
      data: (state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Shuffle
            IconButton(
              icon: Icon(
                PhosphorIcons.shuffle(
                  state.isShuffle ? PhosphorIconsStyle.fill : PhosphorIconsStyle.regular,
                ),
                size: 24,
                color: state.isShuffle
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                ref.read(audioServiceProvider).toggleShuffle(!state.isShuffle);
              },
            ),

            // Previous
            IconButton(
              icon: Icon(
                PhosphorIcons.skipBack(),
                size: 32,
              ),
              onPressed: () {
                ref.read(audioServiceProvider).skipToPrevious();
              },
            ),

            // Play/Pause
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  state.isPlaying
                      ? PhosphorIcons.pause(PhosphorIconsStyle.fill)
                      : PhosphorIcons.play(PhosphorIconsStyle.fill),
                  size: 32,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  final service = ref.read(audioServiceProvider);
                  if (state.isPlaying) {
                    service.pause();
                  } else {
                    if (state.currentSong != null) {
                      service.play(state.currentSong!);
                    }
                  }
                },
              ),
            ),

            // Next
            IconButton(
              icon: Icon(
                PhosphorIcons.skipForward(),
                size: 32,
              ),
              onPressed: () {
                ref.read(audioServiceProvider).skipToNext();
              },
            ),

            // Repeat
            IconButton(
              icon: Icon(
                _getRepeatIcon(state.repeatMode),
                size: 24,
                color: state.repeatMode != RepeatMode.off
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                final nextMode = _getNextRepeatMode(state.repeatMode);
                ref.read(audioServiceProvider).setRepeatMode(nextMode);
              },
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  PhosphorIconData _getRepeatIcon(RepeatMode mode) {
    switch (mode) {
      case RepeatMode.off:
        return PhosphorIcons.repeat();
      case RepeatMode.all:
        return PhosphorIcons.repeat(PhosphorIconsStyle.fill);
      case RepeatMode.one:
        return PhosphorIcons.repeatOnce();
    }
  }

  RepeatMode _getNextRepeatMode(RepeatMode current) {
    switch (current) {
      case RepeatMode.off:
        return RepeatMode.all;
      case RepeatMode.all:
        return RepeatMode.one;
      case RepeatMode.one:
        return RepeatMode.off;
    }
  }
}

/// Secondary controls widget
class _SecondaryControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SecondaryButton(
          icon: PhosphorIcons.queue(),
          label: 'Queue',
          onTap: () {
            // Show queue
          },
        ),
        _SecondaryButton(
          icon: PhosphorIcons.heart(),
          label: 'Like',
          onTap: () {
            // Toggle favorite
          },
        ),
        _SecondaryButton(
          icon: PhosphorIcons.speakerHigh(),
          label: 'Volume',
          onTap: () {
            // Show volume slider
          },
        ),
        _SecondaryButton(
          icon: PhosphorIcons.shareFat(),
          label: 'Share',
          onTap: () {
            // Share song
          },
        ),
      ],
    );
  }
}

/// Secondary button widget
class _SecondaryButton extends StatelessWidget {
  final PhosphorIconData icon;
  final String label;
  final VoidCallback onTap;

  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stream provider for playback state
final playbackStateProvider = StreamProvider<PlaybackState>((ref) {
  final audioService = ref.watch(audioServiceProvider);
  return audioService.playbackStateStream;
});
