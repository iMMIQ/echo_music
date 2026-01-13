import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../data/models/song_model.dart';
import '../../data/services/audio_service.dart';
import '../pages/full_player_page.dart';
import '../providers/audio_provider.dart';

/// Mini player widget displayed at the bottom of the screen
class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateAsync = ref.watch(playbackStateProvider);

    return playbackStateAsync.when(
      data: (state) {
        final song = state.currentSong;

        if (song == null) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => _openFullPlayer(context),
          child: Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: StreamBuilder<Duration>(
                stream: ref.read(audioServiceProvider).positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final progress = state.duration.inMilliseconds > 0
                      ? position.inMilliseconds / state.duration.inMilliseconds
                      : 0.0;

                  return Stack(
                    children: [
                      // Progress bar background
                      Positioned.fill(
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                          minHeight: 64,
                        ),
                      ),
                      // Content
                      Row(
                        children: [
                          // Album art
                          _AlbumArt(song: song),
                          const SizedBox(width: 12),

                          // Song info
                          Expanded(child: _SongInfo(song: song)),

                          // Controls
                          _Controls(state: state, ref: ref),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _openFullPlayer(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const FullPlayerPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0, 1);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}

/// Album art widget
class _AlbumArt extends StatelessWidget {
  const _AlbumArt({required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: song.albumArt != null
            ? DecorationImage(
                image: FileImage(File(song.albumArt!.path)),
                fit: BoxFit.cover,
              )
            : null,
        color: song.albumArt == null
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : null,
      ),
      child: song.albumArt == null
          ? Icon(
              PhosphorIcons.musicNote(),
              size: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            )
          : null,
    );
  }
}

/// Song info widget
class _SongInfo extends StatelessWidget {
  const _SongInfo({required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          song.title,
          style: Theme.of(context).textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          song.artist,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// Controls widget
class _Controls extends StatelessWidget {
  const _Controls({required this.state, required this.ref});
  final PlaybackState state;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous
        IconButton(
          icon: Icon(PhosphorIcons.skipBack(), size: 24),
          onPressed: () {
            final service = ref.read(audioServiceProvider);
            service.skipToPrevious();
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),

        // Play/Pause
        IconButton(
          icon: Icon(
            state.isPlaying
                ? PhosphorIcons.pauseCircle(PhosphorIconsStyle.fill)
                : PhosphorIcons.playCircle(PhosphorIconsStyle.fill),
            size: 32,
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
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),

        // Next
        IconButton(
          icon: Icon(PhosphorIcons.skipForward(), size: 24),
          onPressed: () {
            final service = ref.read(audioServiceProvider);
            service.skipToNext();
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
      ],
    );
  }
}
