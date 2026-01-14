import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/services/audio_background_task.dart';
import 'data/services/hive_service.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MediaKit for cross-platform audio playback
  MediaKit.ensureInitialized();

  // Initialize audio service for background playback
  await AudioBackgroundTask.start();

  // Initialize Hive
  await HiveService.init();

  // Open all boxes
  await HiveService.openBoxes();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    final accentColor = ref.watch(currentAccentColorProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(accentColor: accentColor),
      darkTheme: darkTheme(accentColor: accentColor),
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
