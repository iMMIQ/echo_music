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

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(PhosphorIcons.house),
      selectedIcon: Icon(PhosphorIcons.houseFill),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(PhosphorIcons.books),
      selectedIcon: Icon(PhosphorIcons.booksFill),
      label: 'Library',
    ),
    NavigationDestination(
      icon: Icon(PhosphorIcons.magnifyingGlass),
      selectedIcon: Icon(PhosphorIcons.magnifyingGlassFill),
      label: 'Search',
    ),
    NavigationDestination(
      icon: Icon(PhosphorIcons.gear),
      selectedIcon: Icon(PhosphorIcons.gearFill),
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
        return _buildHomePage();
      case 1:
        return _buildLibraryPage();
      case 2:
        return _buildSearchPage();
      case 3:
        return _buildSettingsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.musicalNote,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to Echo Music',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Start by adding music to your library',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryPage() {
    return Center(
      child: Text(
        'Library',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildSearchPage() {
    return Center(
      child: Text(
        'Search',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildSettingsPage() {
    return Center(
      child: Text(
        'Settings',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
