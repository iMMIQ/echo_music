import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../data/models/settings_model.dart';
import '../providers/settings_provider.dart';

/// Dialog for selecting theme mode
class ThemeModeDialog extends ConsumerWidget {
  const ThemeModeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(settingsProvider).themeMode;

    return AlertDialog(
      title: const Text('Dark Mode'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values.map((mode) {
          final isSelected = mode == currentThemeMode;
          return RadioListTile<ThemeMode>(
            title: Text(_getThemeModeLabel(mode)),
            subtitle: Text(_getThemeModeDescription(mode)),
            value: mode,
            groupValue: currentThemeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(settingsProvider.notifier).setThemeMode(value);
                Navigator.of(context).pop();
              }
            },
            selected: isSelected,
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  String _getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  String _getThemeModeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Follow system settings';
      case ThemeMode.light:
        return 'Always use light theme';
      case ThemeMode.dark:
        return 'Always use dark theme';
    }
  }
}

/// Dialog for selecting accent color
class AccentColorDialog extends ConsumerWidget {
  const AccentColorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(settingsProvider).accentColorIndex;

    return AlertDialog(
      title: const Text('Accent Color'),
      content: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: AccentColors.colors.length,
        itemBuilder: (context, index) {
          final color = AccentColors.colors[index];
          final name = AccentColors.names[index];
          final isSelected = index == currentIndex;

          return InkWell(
            onTap: () {
              ref.read(settingsProvider.notifier).setAccentColor(index);
              Navigator.of(context).pop();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onSurface
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? Icon(
                      PhosphorIcons.check(),
                      color: _getContrastColor(color),
                    )
                  : null,
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Color _getContrastColor(Color color) {
    // Calculate luminance
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

/// Dialog for selecting audio quality
class AudioQualityDialog extends ConsumerWidget {
  const AudioQualityDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentQuality = ref.watch(settingsProvider).audioQuality;

    return AlertDialog(
      title: const Text('Audio Quality'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: AudioQuality.values.map((quality) {
          final isSelected = quality == currentQuality;
          return RadioListTile<AudioQuality>(
            title: Text(quality.label),
            subtitle: Text('${quality.bitrate} kbps'),
            value: quality,
            groupValue: currentQuality,
            onChanged: (value) {
              if (value != null) {
                ref.read(settingsProvider.notifier).setAudioQuality(value);
                Navigator.of(context).pop();
              }
            },
            selected: isSelected,
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

/// Show theme mode dialog
Future<void> showThemeModeDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const ThemeModeDialog(),
  );
}

/// Show accent color dialog
Future<void> showAccentColorDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const AccentColorDialog(),
  );
}

/// Show audio quality dialog
Future<void> showAudioQualityDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const AudioQualityDialog(),
  );
}
