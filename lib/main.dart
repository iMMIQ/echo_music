import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  // await Hive.initFlutter();
  // Register adapters
  // Hive.registerAdapter(SongAdapter());
  // Hive.registerAdapter(AlbumArtAdapter());
  // Hive.registerAdapter(AlbumAdapter());
  // Hive.registerAdapter(ArtistAdapter());
  // Hive.registerAdapter(PlaylistAdapter());

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ThemeMode.dark; // TODO: Get from settings

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
