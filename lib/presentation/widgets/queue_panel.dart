import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../data/models/song_model.dart';
import '../providers/audio_provider.dart';

/// Queue panel widget for managing playback queue
class QueuePanel extends ConsumerWidget {
  const QueuePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStateAsync = ref.watch(playbackStateProvider);

    return playbackStateAsync.when(
      data: (state) {
        final queue = state.queue ?? [];
        final currentIndex = state.currentIndex ?? -1;

        if (queue.isEmpty) {
          return _EmptyQueue();
        }

        return Column(
          children: [
            // Header
            _QueueHeader(
              songCount: queue.length,
              onClear: () => _showClearDialog(context, ref),
            ),

            const Divider(height: 1),

            // Queue list
            Expanded(
              child: ReorderableListView.builder(
                itemCount: queue.length,
                onReorder: (oldIndex, newIndex) =>
                    _reorderQueue(ref, queue, oldIndex, newIndex),
                itemBuilder: (context, index) {
                  final song = queue[index];
                  final isCurrentSong = index == currentIndex;

                  return _QueueItem(
                    key: ValueKey(song.id),
                    song: song,
                    isCurrentSong: isCurrentSong,
                    index: index,
                    onPlay: () => _playSong(ref, song, index),
                    onRemove: () => _removeFromQueue(ref, index),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error loading queue')),
    );
  }

  void _playSong(WidgetRef ref, Song song, int index) {
    ref.read(audioServiceProvider).play(song);
  }

  void _removeFromQueue(WidgetRef ref, int index) {
    ref.read(audioServiceProvider).removeFromQueue(index);
  }

  void _reorderQueue(
    WidgetRef ref,
    List<Song> queue,
    int oldIndex,
    int newIndex,
  ) {
    final service = ref.read(audioServiceProvider);
    // Handle the case where we're moving from before to after
    int adjustedIndex = newIndex;
    if (oldIndex < newIndex) {
      adjustedIndex = newIndex - 1;
    }
    service.moveQueueItem(oldIndex, adjustedIndex);
  }

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Queue'),
        content: const Text('Are you sure you want to clear the entire queue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(audioServiceProvider).clearQueue();
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

/// Empty queue state
class _EmptyQueue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.queue(),
            size: 64,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(height: 16),
          Text(
            'Queue is empty',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add songs to start playing',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

/// Queue header widget
class _QueueHeader extends StatelessWidget {
  const _QueueHeader({required this.songCount, required this.onClear});
  final int songCount;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Next Up ($songCount)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextButton.icon(
            onPressed: onClear,
            icon: Icon(PhosphorIcons.trash(), size: 18),
            label: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

/// Queue item widget
class _QueueItem extends StatelessWidget {
  const _QueueItem({
    required this.song,
    required this.isCurrentSong,
    required this.index,
    required this.onPlay,
    required this.onRemove,
    super.key,
  });
  final Song song;
  final bool isCurrentSong;
  final int index;
  final VoidCallback onPlay;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCurrentSong
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.surfaceContainerHighest),
        ),
      ),
      child: ListTile(
        key: key,
        leading: _buildLeading(context),
        title: Text(
          song.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isCurrentSong ? FontWeight.bold : FontWeight.normal,
            color: isCurrentSong
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          song.artist,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCurrentSong)
              Icon(
                PhosphorIcons.waveform(),
                size: 20,
                color: theme.colorScheme.primary,
              )
            else
              IconButton(
                icon: Icon(PhosphorIcons.x(), size: 20),
                onPressed: onRemove,
                tooltip: 'Remove from queue',
              ),
            IconButton(
              icon: Icon(PhosphorIcons.play(), size: 20),
              onPressed: onPlay,
              tooltip: 'Play this song',
            ),
          ],
        ),
        onTap: onPlay,
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: Center(
          child: isCurrentSong
              ? Icon(
                  PhosphorIcons.speakerHigh(),
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                )
              : Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
        ),
      ),
    );
  }
}
