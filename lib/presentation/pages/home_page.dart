import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      selectedIcon: Icon(PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill)),
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
      body: SafeArea(
        child: _buildPage(_currentIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: _destinations,
        backgroundColor: theme.colorScheme.surface,
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
        Text(
          'Good Evening',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 24),

        // Quick actions
        _QuickActions(),
        const SizedBox(height: 32),

        // Recently played
        _SectionHeader(
          title: 'Recently Played',
          action: TextButton(
            onPressed: () {},
            child: const Text('View All'),
          ),
        ),
        const SizedBox(height: 12),
        _RecentlyPlayedGrid(),
        const SizedBox(height: 32),

        // Made for you
        _SectionHeader(
          title: 'Made for You',
          action: TextButton(
            onPressed: () {},
            child: const Text('View All'),
          ),
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
            icon: Icon(PhosphorIcons.shuffle(PhosphorIconsStyle.fill), size: 28),
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
  final Icon icon;
  final String label;
  final Color color;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
  });

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
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}

/// Section header
class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget action;

  const _SectionHeader({
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
  final String title;
  final String subtitle;
  final PhosphorIconData icon;

  const _RecentlyPlayedCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
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
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
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
      children: [
        _MadeForYouCard(
          title: 'Discover Weekly',
          subtitle: 'Your weekly mixtape',
        ),
        _MadeForYouCard(
          title: 'Release Radar',
          subtitle: 'New music for you',
        ),
      ],
    );
  }
}

/// Made for you card
class _MadeForYouCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _MadeForYouCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    _tabController = TabController(length: 3, vsync: this);
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
              IconButton(
                onPressed: () {},
                icon: Icon(PhosphorIcons.plus()),
              ),
            ],
          ),
        ),

        // Tabs
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Songs'),
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
class _SongsTab extends StatelessWidget {
  const _SongsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.musicNotes(),
            size: 64,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No songs yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add music to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {},
            icon: Icon(PhosphorIcons.plus()),
            label: const Text('Add Music'),
          ),
        ],
      ),
    );
  }
}

/// Albums tab
class _AlbumsTab extends StatelessWidget {
  const _AlbumsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Albums'),
    );
  }
}

/// Artists tab
class _ArtistsTab extends StatelessWidget {
  const _ArtistsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Artists'),
    );
  }
}

/// Search page content
class _SearchPageContent extends StatelessWidget {
  const _SearchPageContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Search bar
        SearchBar(
          leading: Icon(PhosphorIcons.magnifyingGlass()),
          hintText: 'Search songs, albums, artists...',
          onTap: () {},
        ),
        const SizedBox(height: 24),

        // Browse categories
        Text(
          'Browse All',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _BrowseCategoriesGrid(),
      ],
    );
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
        return Container(
          decoration: BoxDecoration(
            color: Color(category['color'] as int),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              category['name'] as String,
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
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
  final String title;
  final List<_SettingsItem> items;

  const _SettingsSection({
    required this.title,
    required this.items,
  });

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
        Card(
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}

/// Settings item
class _SettingsItem extends StatelessWidget {
  final PhosphorIconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

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
