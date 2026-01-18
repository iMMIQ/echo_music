# UI Beautification Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Beautify Echo Music app UI with Neumorphism/Minimalist style

**Architecture:** Update theme system with neumorphic design tokens, apply styles to player and home pages, add micro-interactions

**Tech Stack:** Flutter 3.x, Material 3, Custom Neumorphic widgets

---

## Task 1: Update Theme System with Neumorphic Design Tokens

**Files:**
- Modify: `lib/core/theme/app_theme.dart`

**Step 1: Add Neumorphic Shadow Helper Class**

Run: `cat lib/core/theme/app_theme.dart`
Expected: See current theme structure

**Step 2: Add Neumorphic shadow constants**

Add after line 30 (after existing color definitions):

```dart
/// Neumorphic shadow data class
class NeumorphicShadow {
  final List<BoxShadow> raised;
  final List<BoxShadow> inset;
  final List<BoxShadow> buttonPressed;

  const NeumorphicShadow({
    required this.raised,
    required this.inset,
    required this.buttonPressed,
  });
}

/// Dark mode neumorphic shadows
const neumorphicDark = NeumorphicShadow(
  raised: [
    BoxShadow(color: Color(0x3D0A0B0E), offset: Offset(8, 8), blurRadius: 16),
    BoxShadow(color: 0xFF1A1D26, offset: Offset(-8, -8), blurRadius: 16),
  ],
  inset: [
    BoxShadow(color: Color(0x3D0A0B0E), offset: Offset(4, 4), blurRadius: 8, spreadRadius: 1),
    BoxShadow(color: 0xFF1A1D26, offset: Offset(-4, -4), blurRadius: 8, spreadRadius: 1),
  ],
  buttonPressed: [
    BoxShadow(color: Color(0x3D0A0B0E), offset: Offset(2, 2), blurRadius: 4),
    BoxShadow(color: 0xFF1A1D26, offset: Offset(-2, -2), blurRadius: 4),
  ],
);

/// Light mode neumorphic shadows
const neumorphicLight = NeumorphicShadow(
  raised: [
    BoxShadow(color: Color(0x1AE0E0E0), offset: Offset(6, 6), blurRadius: 12),
    BoxShadow(color: 0xFFFFFFFF, offset: Offset(-6, -6), blurRadius: 12),
  ],
  inset: [
    BoxShadow(color: Color(0x1AE0E0E0), offset: Offset(3, 3), blurRadius: 6, spreadRadius: 1),
    BoxShadow(color: 0xFFFFFFFF, offset: Offset(-3, -3), blurRadius: 6, spreadRadius: 1),
  ],
  buttonPressed: [
    BoxShadow(color: Color(0x1AE0E0E0), offset: Offset(1.5, 1.5), blurRadius: 3),
    BoxShadow(color: 0xFFFFFFFF, offset: Offset(-1.5, -1.5), blurRadius: 3),
  ],
);
```

**Step 3: Update background colors**

Find `darkTheme` and update background color:
```dart
colorScheme: ColorScheme.dark(
  background: const Color(0xFF12141A),  // Changed from #0A0A0B
  // ... rest of colors
),
```

**Step 4: Update border radius constants**

Find `AppBorderRadius` class and update:
```dart
class AppBorderRadius {
  static const double small = 12.0;   // Changed from 8
  static const double medium = 16.0;  // Changed from 12
  static const double large = 20.0;   // Changed from 16
  static const double xLarge = 28.0;  // Changed from 24
}
```

**Step 5: Update animation durations**

Find `AppDuration` class and update:
```dart
class AppDuration {
  static const int fast = 120;    // Changed from 150
  static const int normal = 200;  // Changed from 250
  static const int slow = 300;    // Changed from 350
  static const int slower = 400;  // Changed from 500
}
```

**Step 6: Run build to verify**

Run: `flutter analyze`
Expected: No errors, maybe warnings about unused imports (will be used later)

**Step 7: Commit**

```bash
git add lib/core/theme/app_theme.dart
git commit -m "feat: add neumorphic design tokens to theme system"
```

---

## Task 2: Create Neumorphic Card Widget

**Files:**
- Create: `lib/widgets/neumorphic_card.dart`

**Step 1: Create the neumorphic card widget**

```dart
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final bool isInset;
  final bool isPressed;
  final EdgeInsetsGeometry padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.isInset = false,
    this.isPressed = false,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shadows = isDark ? neumorphicDark : neumorphicLight;

    List<BoxShadow> getShadows() {
      if (isPressed) return shadows.buttonPressed;
      if (isInset) return shadows.inset;
      return shadows.raised;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? AppBorderRadius.medium),
        boxShadow: getShadows(),
      ),
      child: onTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(borderRadius ?? AppBorderRadius.medium),
                child: child,
              ),
            )
          : child,
    );
  }
}
```

**Step 2: Run build to verify**

Run: `flutter analyze lib/widgets/neumorphic_card.dart`
Expected: No errors

**Step 3: Commit**

```bash
git add lib/widgets/neumorphic_card.dart
git commit -m "feat: add neumorphic card widget"
```

---

## Task 3: Create Neumorphic Button Widget

**Files:**
- Create: `lib/widgets/neumorphic_button.dart`

**Step 1: Create the neumorphic button widget**

```dart
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

enum NeumorphicButtonStyle { filled, outlined, tonal }

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final NeumorphicButtonStyle style;
  final Color? accentColor;
  final double? width;
  final double? height;
  final double? iconSize;

  const NeumorphicButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style = NeumorphicButtonStyle.outlined,
    this.accentColor,
    this.width,
    this.height,
    this.iconSize,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shadows = isDark ? neumorphicDark : neumorphicLight;
    final accent = widget.accentColor ?? theme.colorScheme.primary;

    Widget buttonChild = ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _getBackgroundColor(theme, accent),
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          boxShadow: _isPressed ? shadows.buttonPressed : shadows.raised,
          gradient: widget.style == NeumorphicButtonStyle.filled
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent.withOpacity(0.9),
                    accent.withOpacity(0.7),
                  ],
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.iconSize ?? 16),
          child: IconTheme.merge(
            data: IconThemeData(
              size: widget.iconSize ?? 24,
              color: _getTextColor(theme, accent),
            ),
            child: widget.child,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) {
              setState(() => _isPressed = true);
              _scaleController.forward();
            }
          : null,
      onTapUp: widget.onPressed != null
          ? (_) {
              setState(() => _isPressed = false);
              _scaleController.reverse();
              widget.onPressed!();
            }
          : null,
      onTapCancel: () {
        setState(() => _isPressed = false);
        _scaleController.reverse();
      },
      child: buttonChild,
    );
  }

  Color? _getBackgroundColor(ThemeData theme, Color accent) {
    switch (widget.style) {
      case NeumorphicButtonStyle.filled:
        return null; // Gradient handles it
      case NeumorphicButtonStyle.outlined:
        return theme.colorScheme.surface;
      case NeumorphicButtonStyle.tonal:
        return accent.withOpacity(0.15);
    }
  }

  Color _getTextColor(ThemeData theme, Color accent) {
    switch (widget.style) {
      case NeumorphicButtonStyle.filled:
        return Colors.white;
      case NeumorphicButtonStyle.outlined:
        return theme.colorScheme.onSurface;
      case NeumorphicButtonStyle.tonal:
        return accent;
    }
  }
}
```

**Step 2: Run build to verify**

Run: `flutter analyze lib/widgets/neumorphic_button.dart`
Expected: No errors

**Step 3: Commit**

```bash
git add lib/widgets/neumorphic_button.dart
git commit -m "feat: add neumorphic button widget with press animation"
```

---

## Task 4: Update Full Player Page - Album Art with Glow

**Files:**
- Modify: `lib/presentation/pages/full_player_page.dart`

**Step 1: Read current player implementation**

Run: `head -200 lib/presentation/pages/full_player_page.dart`
Expected: See the album art container implementation

**Step 2: Add album art glow effect wrapper**

Find the album art Container (around line 50-80) and wrap it:

```dart
// Before (existing code)
Container(
  width: 280,
  height: 280,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    // ...
  ),
  // ...
)

// After (with glow and breathing animation)
class _AlbumArtWithGlow extends StatefulWidget {
  final String artworkUrl;
  final double size;

  const _AlbumArtWithGlow({
    required this.artworkUrl,
    this.size = 280,
  });

  @override
  State<_AlbumArtWithGlow> createState() => _AlbumArtWithGlowState();
}

class _AlbumArtWithGlowState extends State<_AlbumArtWithGlow>
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
    final accent = theme.colorScheme.primary;

    return ScaleTransition(
      scale: _breathingAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            // Outer glow
            BoxShadow(
              color: accent.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
            // Neumorphic raised shadow
            ...theme.brightness == Brightness.dark
                ? neumorphicDark.raised
                : neumorphicLight.raised,
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(
            widget.artworkUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: theme.colorScheme.surfaceVariant,
                child: Icon(
                  Icons.music_note,
                  size: widget.size * 0.4,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

**Step 3: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 4: Commit**

```bash
git add lib/presentation/pages/full_player_page.dart
git commit -m "feat: add album art glow and breathing animation"
```

---

## Task 5: Update Full Player Page - Neumorphic Control Buttons

**Files:**
- Modify: `lib/presentation/pages/full_player_page.dart`

**Step 1: Replace main play button**

Find the play/pause button (around line 120-150) and replace:

```dart
// Import at top
import '../widgets/neumorphic_button.dart';

// Replace play button
NeumorphicButton(
  style: NeumorphicButtonStyle.filled,
  width: 72,
  height: 72,
  iconSize: 32,
  onPressed: () => player.playpause(),
  child: Icon(
    player.playing ? Icons.pause : Icons.play_arrow,
  ),
)
```

**Step 2: Replace secondary buttons (prev/next/shuffle/repeat)**

```dart
// Previous button
NeumorphicButton(
  style: NeumorphicButtonStyle.outlined,
  width: 56,
  height: 56,
  iconSize: 24,
  onPressed: () => player.seekToPrevious(),
  child: const Icon(Icons.skip_previous),
)

// Next button
NeumorphicButton(
  style: NeumorphicButtonStyle.outlined,
  width: 56,
  height: 56,
  iconSize: 24,
  onPressed: () => player.seekToNext(),
  child: const Icon(Icons.skip_next),
)

// Shuffle button
NeumorphicButton(
  style: NeumorphicButtonStyle.outlined,
  width: 48,
  height: 48,
  iconSize: 20,
  onPressed: () => player.setShuffleMode(),
  child: Icon(
    player.shuffleModeEnabled ? Icons.shuffle : Icons.shuffle,
    color: player.shuffleModeEnabled
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface,
  ),
)

// Repeat button
NeumorphicButton(
  style: NeumorphicButtonStyle.outlined,
  width: 48,
  height: 48,
  iconSize: 20,
  onPressed: () => player.setRepeatMode(),
  child: Icon(
    _getRepeatIcon(player.repeatMode),
    color: player.repeatMode != AudioServiceRepeatMode.off
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface,
  ),
)
```

**Step 3: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 4: Test hot reload**

Run: `flutter run --hot`
Expected: Buttons show neumorphic style with press animation

**Step 5: Commit**

```bash
git add lib/presentation/pages/full_player_page.dart
git commit -m "feat: replace player controls with neumorphic buttons"
```

---

## Task 6: Update Full Player Page - Progress Bar Styling

**Files:**
- Modify: `lib/presentation/pages/full_player_page.dart`

**Step 1: Create custom progress slider theme**

Find the Slider widget and update:

```dart
SliderTheme(
  data: SliderThemeData(
    trackHeight: 6,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 8,
    ),
    overlayShape: const RoundSliderOverlayShape(
      overlayRadius: 16,
    ),
    activeTrackColor: theme.colorScheme.primary,
    inactiveTrackColor: theme.colorScheme.surfaceVariant,
    thumbColor: theme.colorScheme.primary,
    overlayColor: theme.colorScheme.primary.withOpacity(0.2),
    trackShape: _NeumorphicTrackShape(),
  ),
  child: Slider(
    value: position.inSeconds.toDouble(),
    max: duration.inSeconds.toDouble(),
    onChanged: (value) {
      // existing handler
    },
  ),
)
```

**Step 2: Add custom track shape class at bottom of file**

```dart
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
```

**Step 3: Run build and test**

Run: `flutter run`
Expected: Progress bar shows neumorphic inset effect

**Step 4: Commit**

```bash
git add lib/presentation/pages/full_player_page.dart
git commit -m "feat: update progress bar with neumorphic styling"
```

---

## Task 7: Update Full Player Page - Background Blur Effect

**Files:**
- Modify: `lib/presentation/pages/full_player_page.dart`

**Step 1: Add blurred background to Scaffold**

Wrap Scaffold body with Stack:

```dart
Scaffold(
  body: Stack(
    fit: StackFit.expand,
    children: [
      // Blurred background
      Positioned.fill(
        child: Opacity(
          opacity: 0.1,
          child: Image.network(
            artworkUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: theme.colorScheme.background);
            },
          ),
        ),
      ),
      // Gradient overlay
      Positioned.fill(
        child: Container(
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
      ),
      // Content
      SafeArea(
        child: // existing content
      ),
    ],
  ),
)
```

**Step 2: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 3: Commit**

```bash
git add lib/presentation/pages/full_player_page.dart
git commit -m "feat: add blurred album art background to player"
```

---

## Task 8: Update Home Page - Quick Actions with Neumorphic Cards

**Files:**
- Modify: `lib/presentation/pages/home_page.dart`

**Step 1: Import neumorphic card**

```dart
import '../widgets/neumorphic_card.dart';
```

**Step 2: Replace quick action grid items**

Find the quick actions grid (around line 40-80) and replace:

```dart
GridView.count(
  crossAxisCount: 2,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  mainAxisSpacing: 16,
  crossAxisSpacing: 16,
  childAspectRatio: 1.5,
  children: [
    _QuickActionCard(
      icon: Icons.favorite,
      label: 'Favorites',
      onTap: () => // navigate to favorites
    ),
    _QuickActionCard(
      icon: Icons.history,
      label: 'Recent',
      onTap: () => // navigate to recent
    ),
    _QuickActionCard(
      icon: Icons.shuffle,
      label: 'Shuffle',
      onTap: () => // shuffle all
    ),
    _QuickActionCard(
      icon: Icons.playlist_play,
      label: 'Queue',
      onTap: () => // show queue
    ),
  ],
)

// Add this widget class
class _QuickActionCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _hoverAnimation = Tween<double>(begin: 0.0, end: -2.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _hoverAnimation.value),
            child: NeumorphicCard(
              onTap: widget.onTap,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: 32,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.label,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

**Step 3: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 4: Commit**

```bash
git add lib/presentation/pages/home_page.dart
git commit -m "feat: apply neumorphic cards to quick actions"
```

---

## Task 9: Update Home Page - Recently Played Cards

**Files:**
- Modify: `lib/presentation/pages/home_page.dart`

**Step 1: Update recently played card style**

Find the recently played section (around line 80-150) and update:

```dart
ListView.separated(
  separatorBuilder: (_, __) => const SizedBox(height: 8),
  itemCount: recentSongs.length,
  itemBuilder: (context, index) {
    final song = recentSongs[index];
    return NeumorphicCard(
      onTap: () => player.play(song),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: AppBorderRadius.large,
      child: Row(
        children: [
          // Album art
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              song.artworkUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 56,
                  height: 56,
                  color: theme.colorScheme.surfaceVariant,
                  child: const Icon(Icons.music_note),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Play count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${song.playCount}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Duration
          Text(
            _formatDuration(song.duration),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  },
)
```

**Step 2: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 3: Commit**

```bash
git add lib/presentation/pages/home_page.dart
git commit -m "feat: update recently played cards with neumorphic style"
```

---

## Task 10: Update Bottom Navigation Bar - Frosted Glass Effect

**Files:**
- Modify: `lib/presentation/pages/home_page.dart`

**Step 1: Find bottom navigation bar**

Locate the BottomNavigationBar widget (around line 180-220)

**Step 2: Replace with frosted glass style**

```dart
BottomNavigationBar(
  backgroundColor: theme.brightness == Brightness.dark
      ? Colors.black.withOpacity(0.8)
      : Colors.white.withOpacity(0.8),
  elevation: 0,
  type: BottomNavigationBarType.fixed,
  currentIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
  items: [
    BottomNavigationBarItem(
      icon: _AnimatedNavIcon(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        isActive: _currentIndex == 0,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: _AnimatedNavIcon(
        icon: Icons.library_music_outlined,
        activeIcon: Icons.library_music,
        isActive: _currentIndex == 1,
      ),
      label: 'Library',
    ),
    BottomNavigationBarItem(
      icon: _AnimatedNavIcon(
        icon: Icons.search_outlined,
        activeIcon: Icons.search,
        isActive: _currentIndex == 2,
      ),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: _AnimatedNavIcon(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        isActive: _currentIndex == 3,
      ),
      label: 'Settings',
    ),
  ],
)

// Add this widget
class _AnimatedNavIcon extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;

  const _AnimatedNavIcon({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
  });

  @override
  State<_AnimatedNavIcon> createState() => _AnimatedNavIconState();
}

class _AnimatedNavIconState extends State<_AnimatedNavIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_AnimatedNavIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? theme.colorScheme.primary.withOpacity(0.15)
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              widget.isActive ? widget.activeIcon : widget.icon,
              color: widget.isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}
```

**Step 3: Add blur container wrapper**

Wrap the BottomNavigationBar with:

```dart
ClipRect(
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.black.withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        // existing code
      ),
    ),
  ),
)
```

Also add import:
```dart
import 'dart:ui';
```

**Step 4: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 5: Commit**

```bash
git add lib/presentation/pages/home_page.dart
git commit -m "feat: add frosted glass effect to bottom navigation"
```

---

## Task 11: Update MiniPlayer with Neumorphic Style

**Files:**
- Modify: `lib/presentation/widgets/mini_player.dart`

**Step 1: Read current mini player**

Run: `head -100 lib/presentation/widgets/mini_player.dart`
Expected: See the mini player container structure

**Step 2: Apply neumorphic style**

Update the container decoration:

```dart
import '../core/theme/app_theme.dart';
import '../widgets/neumorphic_button.dart';

// In the build method, replace the Container
Container(
  decoration: BoxDecoration(
    color: theme.colorScheme.surface,
    boxShadow: [
      if (theme.brightness == Brightness.dark)
        ...neumorphicDark.raised,
      else
        ...neumorphicLight.raised,
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, -2),
      ),
    ],
  ),
  child: // rest of content
)

// Replace control buttons with NeumorphicButton
Row(
  children: [
    NeumorphicButton(
      style: NeumorphicButtonStyle.outlined,
      width: 40,
      height: 40,
      iconSize: 20,
      onPressed: player.seekToPrevious,
      child: const Icon(Icons.skip_previous),
    ),
    const SizedBox(width: 8),
    NeumorphicButton(
      style: NeumorphicButtonStyle.filled,
      width: 48,
      height: 48,
      iconSize: 24,
      onPressed: player.playpause,
      child: Icon(player.playing ? Icons.pause : Icons.play_arrow),
    ),
    const SizedBox(width: 8),
    NeumorphicButton(
      style: NeumorphicButtonStyle.outlined,
      width: 40,
      height: 40,
      iconSize: 20,
      onPressed: player.seekToNext,
      child: const Icon(Icons.skip_next),
    ),
  ],
)
```

**Step 3: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 4: Commit**

```bash
git add lib/presentation/widgets/mini_player.dart
git commit -m "feat: apply neumorphic style to mini player"
```

---

## Task 12: Add Page Transition Animations

**Files:**
- Create: `lib/core/theme/page_transitions.dart`

**Step 1: Create page transitions**

```dart
import 'package:flutter/material.dart';

class SharedAxisPageTransitionsBuilder extends PageTransitionsBuilder {
  const SharedAxisPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
      child: child,
    );
  }
}

class SlideUpPageTransition extends PageRouteBuilder {
  final Widget child;

  SlideUpPageTransition({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.1);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curveTween = CurveTween(curve: Curves.easeOut);

            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}
```

**Step 2: Apply to app navigation**

Update main.dart or app widget:

```dart
import '../core/theme/page_transitions.dart';

// In MaterialApp theme
theme: ThemeData(
  // existing theme
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: SharedAxisPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: SharedAxisPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: SharedAxisPageTransitionsBuilder(),
    },
  ),
)
```

**Step 3: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 4: Commit**

```bash
git add lib/core/theme/page_transitions.dart lib/main.dart (or relevant app file)
git commit -m "feat: add shared axis page transitions"
```

---

## Task 13: Add Staggered List Entry Animations

**Files:**
- Create: `lib/widgets/staggered_animation_list.dart`

**Step 1: Create staggered animation widget**

```dart
import 'package:flutter/material.dart';

class StaggeredAnimationList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;
  final Duration delay;

  const StaggeredAnimationList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.duration = const Duration(milliseconds: 200),
    this.delay = const Duration(milliseconds: 50),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _StaggeredItem(
          index: index,
          delay: delay,
          duration: duration,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

class _StaggeredItem extends StatefulWidget {
  final int index;
  final Duration delay;
  final Duration duration;
  final Widget child;

  const _StaggeredItem({
    required this.index,
    required this.delay,
    required this.duration,
    required this.child,
  });

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    final totalDelay = Duration(milliseconds: widget.index * widget.delay.inMilliseconds);

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<double>(begin: 0.1, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(totalDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value * 20),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
```

**Step 2: Run build to verify**

Run: `flutter analyze lib/widgets/staggered_animation_list.dart`
Expected: No errors

**Step 3: Commit**

```bash
git add lib/widgets/staggered_animation_list.dart
git commit -m "feat: add staggered list entry animation widget"
```

---

## Task 14: Add Ripple Effect Customization

**Files:**
- Modify: `lib/core/theme/app_theme.dart`

**Step 1: Update splash color in theme**

Add to ThemeData:

```dart
splashFactory: Theme.of(context).brightness == Brightness.dark
    ? InkRipple.splashFactory
    : InkRipple.splashFactory,
splashColor: colorScheme.primary.withOpacity(0.2),
highlightColor: colorScheme.primary.withOpacity(0.1),
```

**Step 2: Create custom ink splash widget**

Create `lib/widgets/custom_ink_well.dart`:

```dart
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class CustomInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? splashColor;

  const CustomInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final splash = splashColor ?? theme.colorScheme.primary.withOpacity(0.2);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppBorderRadius.medium),
        splashColor: splash,
        highlightColor: splash.withOpacity(0.5),
        child: child,
      ),
    );
  }
}
```

**Step 3: Run build to verify**

Run: `flutter analyze`
Expected: No errors

**Step 4: Commit**

```bash
git add lib/core/theme/app_theme.dart lib/widgets/custom_ink_well.dart
git commit -m "feat: add custom ripple effect with theme color"
```

---

## Task 15: Add Loading Skeleton Screen

**Files:**
- Create: `lib/widgets/neumorphic_skeleton.dart`

**Step 1: Create skeleton widget**

```dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/theme/app_theme.dart';

class NeumorphicSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const NeumorphicSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceVariant;
    final highlightColor = theme.brightness == Brightness.dark
        ? baseColor.withOpacity(0.5)
        : Colors.white.withOpacity(0.8);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: borderRadius ?? BorderRadius.circular(AppBorderRadius.medium),
        boxShadow: theme.brightness == Brightness.dark
            ? neumorphicDark.raised
            : neumorphicLight.raised,
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: borderRadius ?? BorderRadius.circular(AppBorderRadius.medium),
          ),
        ),
      ),
    );
  }
}

class SongListSkeleton extends StatelessWidget {
  const SongListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return NeumorphicCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              NeumorphicSkeleton(width: 56, height: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NeumorphicSkeleton(
                      width: double.infinity,
                      height: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    NeumorphicSkeleton(
                      width: 120,
                      height: 14,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

**Note:** This requires shimmer package. Add to pubspec.yaml if not present:
```yaml
dependencies:
  shimmer: ^3.0.0
```

**Step 2: Run build to verify**

Run: `flutter pub get && flutter analyze`
Expected: No errors

**Step 3: Commit**

```bash
git add lib/widgets/neumorphic_skeleton.dart pubspec.yaml
git commit -m "feat: add neumorphic skeleton loading screens"
```

---

## Task 16: Final Testing and Polish

**Files:**
- Test: All modified files

**Step 1: Run full analyze**

Run: `flutter analyze`
Expected: No errors

**Step 2: Run tests**

Run: `flutter test`
Expected: All tests pass

**Step 3: Build release version**

Run: `flutter build apk --release` (Android)
or `flutter build macos --release` (macOS)

**Step 4: Manual testing checklist**

- [ ] Player page: Album art breathing animation works
- [ ] Player page: Buttons show press animation
- [ ] Player page: Progress bar shows neumorphic style
- [ ] Player page: Background blur effect visible
- [ ] Home page: Quick actions have hover effect
- [ ] Home page: Recently played cards show neumorphic style
- [ ] Bottom nav: Frosted glass effect visible
- [ ] Bottom nav: Active tab has scale animation
- [ ] Mini player: Neumorphic buttons
- [ ] Page transitions: Smooth animations
- [ ] Dark mode: All styles work correctly
- [ ] Light mode: All styles work correctly

**Step 5: Commit final version**

```bash
git add .
git commit -m "chore: final polish and testing for UI beautification"
```

**Step 6: Create git tag**

```bash
git tag -a v0.2.0 -m "UI Beautification Release - Neumorphic Design"
git push origin v0.2.0
```

---

## Summary

This plan implements a complete UI beautification with:
- 16 tasks covering theme, widgets, pages, and animations
- Neumorphic design system with shadows and animations
- Updated player page with glowing album art and animated controls
- Refreshed home page with neumorphic cards
- Smooth page transitions and micro-interactions

**Total estimated steps:** 80+ bite-sized actions
**Tech:** Flutter 3.x, Material 3, Custom widgets
**Design Style:** Neumorphism/Minimalist with soft shadows and animations
