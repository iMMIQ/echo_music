import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../data/models/song_model.dart';
import '../providers/audio_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/library_provider.dart';
import '../providers/search_provider.dart';
import '../widgets/mini_player.dart';

/// Home page of the app
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  final List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(PhosphorIcons.house()),
      selectedIcon: Icon(PhosphorIcons.house(PhosphorIconsStyle.fill)),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(PhosphorIcons.books()),
      selectedIcon: Icon(PhosphorIcons.books(PhosphorIconsStyle.fill)),
      label: 'Library',
    ),
    NavigationDestination(
      icon: Icon(PhosphorIcons.magnifyingGlass()),
      selectedIcon: Icon(
        PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill),
      ),
      label: 'Search',
    ),
    NavigationDestination(
      icon: Icon(PhosphorIcons.gear()),
      selectedIcon: Icon(PhosphorIcons.gear(PhosphorIconsStyle.fill)),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Main content
              Expanded(child: SafeArea(child: _buildPage(_currentIndex))),
              // Bottom navigation
              NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                destinations: _destinations,
                backgroundColor: theme.colorScheme.surface,
              ),
            ],
          ),
          // Mini player
          const Positioned(left: 0, right: 0, bottom: 80, child: MiniPlayer()),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const _HomePageContent();
      case 1:
        return const _LibraryPageContent();
      case 2:
        return const _SearchPageContent();
      case 3:
        return const _SettingsPageContent();
      default:
        return const _HomePageContent();
    }
  }
}

/// Home page content
class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text('Good Evening', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 24),

        // Quick actions
        _QuickActions(),
        const SizedBox(height: 32),

        // Recently played
        _SectionHeader(
          title: 'Recently Played',
          action: TextButton(onPressed: () {}, child: const Text('View All')),
        ),
        const SizedBox(height: 12),
        _RecentlyPlayedGrid(),
        const SizedBox(height: 32),

        // Made for you
        _SectionHeader(
          title: 'Made for You',
          action: TextButton(onPressed: () {}, child: const Text('View All')),
        ),
        const SizedBox(height: 12),
        _MadeForYouGrid(),
      ],
    );
  }
}

/// Quick actions grid
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icon(PhosphorIcons.heart(PhosphorIconsStyle.fill), size: 28),
            label: 'Favorites',
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icon(PhosphorIcons.clock(PhosphorIconsStyle.fill), size: 28),
            label: 'Recent',
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icon(
              PhosphorIcons.shuffle(PhosphorIconsStyle.fill),
              size: 28,
            ),
            label: 'Shuffle',
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}

/// Quick action card
class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
  });
  final Icon icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(color: color),
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

/// Section header
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action});
  final String title;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        action,
      ],
    );
  }
}

/// Recently played grid
class _RecentlyPlayedGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _RecentlyPlayedCard(
          title: 'Liked Songs',
          subtitle: '234 songs',
          icon: PhosphorIcons.heart(PhosphorIconsStyle.fill),
        ),
        _RecentlyPlayedCard(
          title: 'Daily Mix',
          subtitle: 'Based on your taste',
          icon: PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
        ),
        _RecentlyPlayedCard(
          title: 'Chill Vibes',
          subtitle: 'Playlist',
          icon: PhosphorIcons.musicNote(PhosphorIconsStyle.fill),
        ),
        _RecentlyPlayedCard(
          title: 'Workout',
          subtitle: 'Playlist',
          icon: PhosphorIcons.lightning(PhosphorIconsStyle.fill),
        ),
      ],
    );
  }
}

/// Recently played card
class _RecentlyPlayedCard extends StatelessWidget {
  const _RecentlyPlayedCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final PhosphorIconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Made for you grid
class _MadeForYouGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: const [
        _MadeForYouCard(
          title: 'Discover Weekly',
          subtitle: 'Your weekly mixtape',
        ),
        _MadeForYouCard(title: 'Release Radar', subtitle: 'New music for you'),
      ],
    );
  }
}

/// Made for you card
class _MadeForYouCard extends StatelessWidget {
  const _MadeForYouCard({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
            Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Library page content
class _LibraryPageContent extends StatefulWidget {
  const _LibraryPageContent();

  @override
  State<_LibraryPageContent> createState() => _LibraryPageContentState();
}

class _LibraryPageContentState extends State<_LibraryPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Library',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.plus())),
            ],
          ),
        ),

        // Tabs
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Songs'),
            Tab(text: 'Favorites'),
            Tab(text: 'Albums'),
            Tab(text: 'Artists'),
          ],
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _SongsTab(),
              _FavoritesTab(),
              _AlbumsTab(),
              _ArtistsTab(),
            ],
          ),
        ),
      ],
    );
  }
}

/// Songs tab
class _SongsTab extends ConsumerWidget {
  const _SongsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsync = ref.watch(allSongsProvider);

    return songsAsync.when(
      data: (songs) {
        if (songs.isEmpty) {
          return _EmptyLibraryState();
        }

        return ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return _SongListItem(
              song: song,
              index: index,
              onTap: () => _playSong(context, ref, song),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  void _playSong(BuildContext context, WidgetRef ref, Song song) {
    final audioService = ref.read(audioServiceProvider);
    audioService.play(song);
  }
}

/// Empty library state widget
class _EmptyLibraryState extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.musicNotes(),
            size: 64,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(height: 16),
          Text(
            'No songs yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add music to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _importMusic(context, ref),
            icon: Icon(PhosphorIcons.plus()),
            label: const Text('Add Music'),
          ),
        ],
      ),
    );
  }

  Future<void> _importMusic(BuildContext context, WidgetRef ref) async {
    final importController = ref.read(importControllerProvider.notifier);
    final songs = await importController.importFiles();

    if (context.mounted && songs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Imported ${songs.length} song(s)'),
          action: SnackBarAction(label: 'View', onPressed: () {}),
        ),
      );
    }
  }
}

/// Song list item widget
class _SongListItem extends ConsumerWidget {
  const _SongListItem({
    required this.song,
    required this.index,
    required this.onTap,
  });
  final Song song;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteSongsProvider);

    return favoritesAsync.when(
      data: (favorites) {
        final isFavorite = favorites.any((s) => s.id == song.id);

        return ListTile(
          leading: _buildAlbumArt(context),
          title: Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            '${song.artist} • ${song.album}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Duration
              Text(
                _formatDuration(song.duration),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(width: 8),
              // Favorite button
              IconButton(
                icon: Icon(
                  isFavorite
                      ? PhosphorIcons.heart(PhosphorIconsStyle.fill)
                      : PhosphorIcons.heart(),
                  size: 20,
                  color: isFavorite
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                onPressed: () => _toggleFavorite(ref, song.id),
              ),
            ],
          ),
          onTap: onTap,
        );
      },
      loading: () => ListTile(
        leading: _buildAlbumArt(context),
        title: Text(song.title),
        subtitle: Text('${song.artist} • ${song.album}'),
        trailing: Text(_formatDuration(song.duration)),
        onTap: onTap,
      ),
      error: (_, __) => ListTile(
        leading: _buildAlbumArt(context),
        title: Text(song.title),
        subtitle: Text('${song.artist} • ${song.album}'),
        trailing: Text(_formatDuration(song.duration)),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAlbumArt(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: song.albumArt != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(song.albumArt!.path),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    PhosphorIcons.musicNote(),
                    size: 24,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  );
                },
              ),
            )
          : Icon(
              PhosphorIcons.musicNote(),
              size: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> _toggleFavorite(WidgetRef ref, String songId) async {
    await ref.read(favoritesControllerProvider.notifier).toggleFavorite(songId);
  }
}

/// Albums tab
class _AlbumsTab extends StatelessWidget {
  const _AlbumsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Albums'));
  }
}

/// Favorites tab
class _FavoritesTab extends ConsumerWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteSongsProvider);

    return favoritesAsync.when(
      data: (favorites) {
        if (favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.heart(),
                  size: 64,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Like some songs to see them here',
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

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final song = favorites[index];
            return _SongListItem(
              song: song,
              index: index,
              onTap: () => _playSong(context, ref, song),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  void _playSong(BuildContext context, WidgetRef ref, Song song) {
    final audioService = ref.read(audioServiceProvider);
    audioService.play(song);
  }
}

/// Artists tab
class _ArtistsTab extends StatelessWidget {
  const _ArtistsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Artists'));
  }
}

/// Search page content
class _SearchPageContent extends ConsumerStatefulWidget {
  const _SearchPageContent();

  @override
  ConsumerState<_SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends ConsumerState<_SearchPageContent> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(searchQueryProvider.notifier).updateQuery(query);
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchBar(
            controller: _searchController,
            focusNode: _focusNode,
            leading: Icon(PhosphorIcons.magnifyingGlass()),
            trailing: searchQuery.isNotEmpty
                ? [
                    IconButton(
                      icon: Icon(PhosphorIcons.x()),
                      onPressed: _clearSearch,
                    ),
                  ]
                : null,
            hintText: 'Search songs, albums, artists...',
            onChanged: _onSearchChanged,
          ),
        ),

        // Content
        Expanded(
          child: searchQuery.isEmpty
              ? _BrowseContent()
              : _SearchResultsContent(),
        ),
      ],
    );
  }
}

/// Browse content (when search is empty)
class _BrowseContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSongsAsync = ref.watch(allSongsProvider);

    return allSongsAsync.when(
      data: (songs) {
        if (songs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.musicNotes(),
                  size: 64,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: 16),
                Text(
                  'No music in library',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add some songs to get started',
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

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text('Browse All', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _BrowseCategoriesGrid(),
            const SizedBox(height: 24),
            Text(
              'Recently Added',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...songs
                .take(10)
                .map(
                  (song) => _SongListItem(
                    song: song,
                    index: songs.indexOf(song),
                    onTap: () => _playSong(context, ref, song),
                  ),
                ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error loading library')),
    );
  }

  void _playSong(BuildContext context, WidgetRef ref, Song song) {
    final audioService = ref.read(audioServiceProvider);
    audioService.play(song);
  }
}

/// Search results content
class _SearchResultsContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(searchResultsProvider);

    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.magnifyingGlass(),
                  size: 64,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: 16),
                Text(
                  'No results found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try a different search term',
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

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            // Results summary
            if (results.totalResults > 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Found ${results.totalResults} results',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),

            // Songs section
            if (results.songs.isNotEmpty) ...[
              Text(
                'Songs (${results.songs.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...results.songs.map(
                (song) => _SongListItem(
                  song: song,
                  index: results.songs.indexOf(song),
                  onTap: () => _playSong(context, ref, song),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Artists section
            if (results.artists.isNotEmpty) ...[
              Text(
                'Artists (${results.artists.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: results.artists.map((artist) {
                  return Chip(
                    label: Text(artist),
                    avatar: Icon(PhosphorIcons.user(), size: 18),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // Albums section
            if (results.albums.isNotEmpty) ...[
              Text(
                'Albums (${results.albums.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: results.albums.map((album) {
                  return Chip(
                    label: Text(album),
                    avatar: Icon(PhosphorIcons.vinylRecord(), size: 18),
                  );
                }).toList(),
              ),
            ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error searching')),
    );
  }

  void _playSong(BuildContext context, WidgetRef ref, Song song) {
    final audioService = ref.read(audioServiceProvider);
    audioService.play(song);
  }
}

/// Browse categories grid
class _BrowseCategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Pop', 'color': 0xFF6366F1},
      {'name': 'Rock', 'color': 0xFFEC4899},
      {'name': 'Hip-Hop', 'color': 0xFFF59E0B},
      {'name': 'Jazz', 'color': 0xFF10B981},
      {'name': 'Classical', 'color': 0xFF8B5CF6},
      {'name': 'Electronic', 'color': 0xFF3B82F6},
      {'name': 'R&B', 'color': 0xFFEF4444},
      {'name': 'Country', 'color': 0xFF14B8A6},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Color(category['color']! as int),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              category['name']! as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Settings page content
class _SettingsPageContent extends StatelessWidget {
  const _SettingsPageContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),

        // Settings sections
        _SettingsSection(
          title: 'Audio',
          items: [
            _SettingsItem(
              icon: PhosphorIcons.speakerHigh(),
              title: 'Audio Quality',
              subtitle: 'High',
              onTap: () {},
            ),
            _SettingsItem(
              icon: PhosphorIcons.equalizer(),
              title: 'Equalizer',
              subtitle: 'Not configured',
              onTap: () {},
            ),
            _SettingsItem(
              icon: PhosphorIcons.waveform(),
              title: 'Crossfade',
              subtitle: 'Off',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),

        _SettingsSection(
          title: 'Library',
          items: [
            _SettingsItem(
              icon: PhosphorIcons.folder(),
              title: 'Music Folders',
              subtitle: 'No folders added',
              onTap: () {},
            ),
            _SettingsItem(
              icon: PhosphorIcons.arrowCounterClockwise(),
              title: 'Auto-refresh',
              subtitle: 'On app start',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),

        _SettingsSection(
          title: 'Appearance',
          items: [
            _SettingsItem(
              icon: PhosphorIcons.moon(),
              title: 'Dark Mode',
              subtitle: 'On',
              onTap: () {},
            ),
            _SettingsItem(
              icon: PhosphorIcons.palette(),
              title: 'Accent Color',
              subtitle: 'Indigo',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),

        _SettingsSection(
          title: 'About',
          items: [
            _SettingsItem(
              icon: PhosphorIcons.info(),
              title: 'Version',
              subtitle: '0.1.0',
              onTap: () {},
            ),
            _SettingsItem(
              icon: PhosphorIcons.githubLogo(),
              title: 'GitHub',
              subtitle: 'View source code',
              onTap: () {},
            ),
            _SettingsItem(
              icon: PhosphorIcons.heart(),
              title: 'License',
              subtitle: 'GPL v3.0',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

/// Settings section
class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.items});
  final String title;
  final List<_SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Card(child: Column(children: items)),
      ],
    );
  }
}

/// Settings item
class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final PhosphorIconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(PhosphorIcons.caretRight()),
      onTap: onTap,
    );
  }
}
