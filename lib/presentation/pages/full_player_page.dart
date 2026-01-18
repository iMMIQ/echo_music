import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../core/theme/app_theme.dart';
import '../../data/services/audio_service.dart' as audio_service;
import '../../widgets/neumorphic_button.dart';

import '../providers/audio_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/library_provider.dart';
import '../widgets/queue_panel.dart';

/// Full-screen music player page
class FullPlayerPage extends ConsumerStatefulWidget {
  const FullPlayerPage({super.key});

  @override
  ConsumerState<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends ConsumerState<FullPlayerPage> {
  void _showQueuePanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (context, scrollController) => DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Queue panel
              const Expanded(child: QueuePanel()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred background
          Consumer(
            builder: (context, ref, _) {
              final playbackStateAsync = ref.watch(playbackStateProvider);
              return playbackStateAsync.when(
                data: (state) {
                  final song = state.currentSong;
                  if (song == null || song.albumArt == null) {
                    return Container(color: theme.colorScheme.background);
                  }
                  return Opacity(
                    opacity: 0.1,
                    child: Image.file(
                      File(song.albumArt!.path),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                loading: () => Container(color: theme.colorScheme.background),
                error: (_, __) => Container(color: theme.colorScheme.background),
              );
            },
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.background.withOpacity(0.3),
                  theme.colorScheme.background.withOpacity(0.7),
                  theme.colorScheme.background,
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Header
                  _buildHeader(context),

                  // Album art - takes available space
                  const Expanded(
                    child: Center(
                      child: _AlbumArtWithGlow(),
                    ),
                  ),

                  // Song info
                  _SongInfo(),

                  const SizedBox(height: 12),

                  // Progress bar
                  _ProgressBar(),

                  const SizedBox(height: 12),

                  // Main controls
                  _MainControls(),

                  const SizedBox(height: 8),

                  // Secondary controls
                  _SecondaryControls(onShowQueue: _showQueuePanel),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
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
            icon: Icon(PhosphorIcons.caretDown(), size: 32),
            onPressed: () => Navigator.of(context).pop(),
          ),

          // "Now Playing" label
          Text('Now Playing', style: Theme.of(context).textTheme.titleMedium),

          // More options
          IconButton(
            icon: Icon(PhosphorIcons.dotsThree(), size: 24),
            onPressed: () {
              // Show more options menu
            },
          ),
        ],
      ),
    );
  }
}

/// Album art widget with glow and breathing animation
class _AlbumArtWithGlow extends ConsumerStatefulWidget {
  const _AlbumArtWithGlow();

  @override
  ConsumerState<_AlbumArtWithGlow> createState() => _AlbumArtWithGlowState();
}

class _AlbumArtWithGlowState extends ConsumerState<_AlbumArtWithGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playbackStateAsync = ref.watch(playbackStateProvider);
    final screenSize = MediaQuery.of(context).size;
    // Responsive album art size - about 35-40% of screen height
    final artSize = (screenSize.height * 0.38).clamp(220.0, 320.0);

    return playbackStateAsync.when(
      data: (state) {
        final song = state.currentSong;
        if (song == null) return const SizedBox.shrink();

        final accent = theme.colorScheme.primary;
        final isDark = theme.brightness == Brightness.dark;

        return ScaleTransition(
          scale: _breathingAnimation,
          child: Container(
            width: artSize,
            height: artSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                // Outer glow
                BoxShadow(
                  color: accent.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
                // Neumorphic raised shadow
                if (isDark) ...neumorphicDark.raised else ...neumorphicLight.raised,
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: song.albumArt != null
                  ? Image.file(File(song.albumArt!.path), fit: BoxFit.cover)
                  : ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        PhosphorIcons.musicNote(),
                        size: artSize * 0.4,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              song.artist,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              song.album,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
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
  double _sliderValue = 0;
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
            ? Duration(
                milliseconds: (_sliderValue * state.duration.inMilliseconds)
                    .round(),
              )
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
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                thumbColor: Theme.of(context).colorScheme.primary,
                overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                trackShape: _NeumorphicTrackShape(),
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
                    milliseconds: (value * state.duration.inMilliseconds)
                        .round(),
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
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    _formatDuration(state.duration),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
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
    final theme = Theme.of(context);

    return playbackStateAsync.when(
      data: (state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Shuffle
            NeumorphicButton(
              style: NeumorphicButtonStyle.outlined,
              width: 48,
              height: 48,
              iconSize: 20,
              accentColor:
                  state.isShuffle ? theme.colorScheme.primary : null,
              onPressed: () {
                ref.read(audioServiceProvider).toggleShuffle(!state.isShuffle);
              },
              child: Icon(
                PhosphorIcons.shuffle(
                  state.isShuffle
                      ? PhosphorIconsStyle.fill
                      : PhosphorIconsStyle.regular,
                ),
              ),
            ),

            // Previous
            NeumorphicButton(
              style: NeumorphicButtonStyle.outlined,
              width: 56,
              height: 56,
              iconSize: 24,
              onPressed: () {
                ref.read(audioServiceProvider).skipToPrevious();
              },
              child: Icon(PhosphorIcons.skipBack()),
            ),

            // Play/Pause
            NeumorphicButton(
              style: NeumorphicButtonStyle.filled,
              width: 72,
              height: 72,
              iconSize: 32,
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
              child: Icon(
                state.isPlaying
                    ? PhosphorIcons.pause(PhosphorIconsStyle.fill)
                    : PhosphorIcons.play(PhosphorIconsStyle.fill),
              ),
            ),

            // Next
            NeumorphicButton(
              style: NeumorphicButtonStyle.outlined,
              width: 56,
              height: 56,
              iconSize: 24,
              onPressed: () {
                ref.read(audioServiceProvider).skipToNext();
              },
              child: Icon(PhosphorIcons.skipForward()),
            ),

            // Repeat
            NeumorphicButton(
              style: NeumorphicButtonStyle.outlined,
              width: 48,
              height: 48,
              iconSize: 20,
              accentColor: state.repeatMode != audio_service.RepeatMode.off
                  ? theme.colorScheme.primary
                  : null,
              onPressed: () {
                final nextMode = _getNextRepeatMode(state.repeatMode);
                ref.read(audioServiceProvider).setRepeatMode(nextMode);
              },
              child: Icon(_getRepeatIcon(state.repeatMode)),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  PhosphorIconData _getRepeatIcon(audio_service.RepeatMode mode) {
    switch (mode) {
      case audio_service.RepeatMode.off:
        return PhosphorIcons.repeat();
      case audio_service.RepeatMode.all:
        return PhosphorIcons.repeat(PhosphorIconsStyle.fill);
      case audio_service.RepeatMode.one:
        return PhosphorIcons.repeatOnce();
    }
  }

  audio_service.RepeatMode _getNextRepeatMode(
      audio_service.RepeatMode current) {
    switch (current) {
      case audio_service.RepeatMode.off:
        return audio_service.RepeatMode.all;
      case audio_service.RepeatMode.all:
        return audio_service.RepeatMode.one;
      case audio_service.RepeatMode.one:
        return audio_service.RepeatMode.off;
    }
  }
}

/// Secondary controls widget
class _SecondaryControls extends ConsumerWidget {
  const _SecondaryControls({required this.onShowQueue});
  final VoidCallback onShowQueue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateAsync = ref.watch(playbackStateProvider);
    final favoritesAsync = ref.watch(favoriteSongsProvider);

    return playbackStateAsync.when(
      data: (state) {
        final currentSong = state.currentSong;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SecondaryButton(
              icon: PhosphorIcons.queue(),
              label: 'Queue',
              onTap: onShowQueue,
            ),
            if (currentSong != null)
              favoritesAsync.when(
                data: (favorites) {
                  final isFavorite = favorites.any(
                    (s) => s.id == currentSong.id,
                  );
                  return _SecondaryButton(
                    icon: isFavorite
                        ? PhosphorIcons.heart(PhosphorIconsStyle.fill)
                        : PhosphorIcons.heart(),
                    label: 'Like',
                    onTap: () => _toggleFavorite(ref, currentSong.id),
                    isActive: isFavorite,
                  );
                },
                loading: () => _SecondaryButton(
                  icon: PhosphorIcons.heart(),
                  label: 'Like',
                  onTap: () {},
                ),
                error: (_, __) => _SecondaryButton(
                  icon: PhosphorIcons.heart(),
                  label: 'Like',
                  onTap: () {},
                ),
              )
            else
              _SecondaryButton(
                icon: PhosphorIcons.heart(),
                label: 'Like',
                onTap: () {},
              ),
            _SecondaryButton(
              icon: PhosphorIcons.speakerHigh(),
              label: 'Volume',
              onTap: () => _showVolumeSlider(context),
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
      },
      loading: () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SecondaryButton(
            icon: PhosphorIcons.queue(),
            label: 'Queue',
            onTap: onShowQueue,
          ),
          _SecondaryButton(
            icon: PhosphorIcons.heart(),
            label: 'Like',
            onTap: () {},
          ),
          _SecondaryButton(
            icon: PhosphorIcons.speakerHigh(),
            label: 'Volume',
            onTap: () {},
          ),
          _SecondaryButton(
            icon: PhosphorIcons.shareFat(),
            label: 'Share',
            onTap: () {},
          ),
        ],
      ),
      error: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SecondaryButton(
            icon: PhosphorIcons.queue(),
            label: 'Queue',
            onTap: onShowQueue,
          ),
          _SecondaryButton(
            icon: PhosphorIcons.heart(),
            label: 'Like',
            onTap: () {},
          ),
          _SecondaryButton(
            icon: PhosphorIcons.speakerHigh(),
            label: 'Volume',
            onTap: () {},
          ),
          _SecondaryButton(
            icon: PhosphorIcons.shareFat(),
            label: 'Share',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavorite(WidgetRef ref, String songId) async {
    await ref.read(favoritesControllerProvider.notifier).toggleFavorite(songId);
  }

  void _showVolumeSlider(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _VolumeSliderDialog(),
    );
  }
}

/// Secondary button widget
class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });
  final PhosphorIconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

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
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Volume slider dialog
class _VolumeSliderDialog extends ConsumerStatefulWidget {
  const _VolumeSliderDialog();

  @override
  ConsumerState<_VolumeSliderDialog> createState() => _VolumeSliderDialogState();
}

class _VolumeSliderDialogState extends ConsumerState<_VolumeSliderDialog> {
  @override
  Widget build(BuildContext context) {
    final audioService = ref.watch(audioServiceProvider);

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            PhosphorIcons.speakerHigh(),
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          const Text('Volume'),
        ],
      ),
      content: StreamBuilder<double>(
        stream: audioService.volumeStream,
        initialData: audioService.volume,
        builder: (context, snapshot) {
          final volume = snapshot.data ?? 1.0;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).colorScheme.primary,
                  inactiveTrackColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  thumbColor: Theme.of(context).colorScheme.primary,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  trackHeight: 6,
                ),
                child: Slider(
                  value: volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  label: '${(volume * 100).round()}%',
                  onChanged: (value) {
                    ref.read(audioServiceProvider).setVolume(value);
                  },
                ),
              ),
              Text(
                '${(volume * 100).round()}%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _NeumorphicTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
