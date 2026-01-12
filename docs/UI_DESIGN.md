# Echo Music - UI/UX Design Guide

## Design Philosophy

Echo Music embraces **modern minimalism** with a focus on:

1. **Content First** - Music and artwork take center stage
2. **Fluid Motion** - Smooth, meaningful animations (60fps)
3. **Visual Hierarchy** - Clear focus on primary actions
4. **Adaptive Beauty** - UI that adapts to content (album art colors)

## Color System

### Dark Theme (Default)

```dart
// Base colors
background: #0A0A0B      // Deepest black
surface: #121214         // Slightly lighter for cards
surfaceVariant: #1C1C1E  // Elevated surfaces

// Content colors
textPrimary: #FFFFFF     // Pure white
textSecondary: #A0A0A5   // Muted gray
textTertiary: #5E5E61    // Disabled text

// Accent colors
primary: #6366F1         // Indigo 500
primaryVariant: #818CF8  // Indigo 400
secondary: #EC4899       // Pink 500

// Semantic colors
error: #EF4444           // Red 500
success: #10B981         // Green 500
warning: #F59E0B         // Amber 500
```

### Light Theme

```dart
// Base colors
background: #FAFAFA      // Off-white
surface: #FFFFFF         // Pure white
surfaceVariant: #F3F4F6  // Light gray

// Content colors
textPrimary: #111827     // Near black
textSecondary: #6B7280   // Medium gray
textTertiary: #9CA3AF    // Light gray

// Accent colors (same as dark theme)
primary: #6366F1
primaryVariant: #4F46E5
secondary: #EC4899
```

### Adaptive Color Extraction

Extract dominant colors from album artwork to create personalized themes:

```dart
// Usage
final artworkColors = await ArtworkColorExtractor.extract(image);
theme = theme.copyWith(
  primaryColor: artworkColors.dominant,
  accentColor: artworkColors.vibrant,
);
```

## Typography

### Font Families

- **Primary**: SF Pro (iOS/macOS), Roboto (Android), Segoe UI (Windows)
- **Fallback**: system-ui

### Type Scale

```dart
// Display
displayLarge: 57px, Bold      // Full-screen player title
displayMedium: 45px, Bold     // Section headers
displaySmall: 36px, Semibold  // Subsection headers

// Headline
headlineLarge: 32px, Semibold  // Page titles
headlineMedium: 28px, Medium   // Card titles
headlineSmall: 24px, Regular   // List headers

// Title
titleLarge: 22px, Medium      // Song titles
titleMedium: 16px, Medium     // Subtitles
titleSmall: 14px, Regular     // Labels

// Body
bodyLarge: 16px, Regular      // Primary text
bodyMedium: 14px, Regular     // Secondary text
bodySmall: 12px, Regular      // Captions

// Label
labelLarge: 14px, Medium      // Buttons
labelMedium: 12px, Medium     // Tags
labelSmall: 11px, Medium      // Small tags
```

## Spacing System

Based on 8dp grid:

```dart
spacing0: 0
spacing1: 4px
spacing2: 8px
spacing3: 12px
spacing4: 16px
spacing5: 20px
spacing6: 24px
spacing8: 32px
spacing10: 40px
spacing12: 48px
spacing16: 64px
spacing20: 80px
```

## Component Design

### 1. Mini Player

**Location**: Fixed at bottom of screen

**Appearance:**
- Height: 64px
- Rounded top corners: 16px
- Elevation: 8dp (subtle shadow)
- Background: Surface color with 0.95 opacity

**Content:**
```
[Album Art 56px]  [Title, Artist]  [Progress]  [Controls]
    56x56              flexible          flexible    32px each
```

**Behavior:**
- Tap → Expand to full player (hero animation)
- Swipe up → Expand to full player
- Swipe down → Dismiss (when in full player)

### 2. Full Player

**Layout**: Stacked, scrollable

**Components:**
1. **Album Art** (256x256, centered)
   - Rounded corners: 24px
   - Shadow: 24dp
   - Subtle parallax on scroll

2. **Song Info**
   - Title (displaySmall)
   - Artist (titleMedium)
   - Album (bodySmall)

3. **Progress Bar**
   - Thin: 4px height
   - Rounded caps
   - Buffered portion shown in secondary color

4. **Controls**
   - Shuffle/Repeat (24px, secondary when inactive, primary when active)
   - Previous/Next (32px)
   - Play/Pause (56px, elevated, prominent)

5. **Additional Controls**
   - Volume slider
   - Queue toggle
   - More options

### 3. Library View

**Layout**: Tab-based navigation

**Tabs**:
- Songs (list view)
- Albums (grid view, 2 columns)
- Artists (list view with avatars)

**List Item Design:**
```
[Number]  [Album Art 48px]  [Title, Artist]  [Duration]
  24px         48x48            flexible          56px
```

**Grid Item (Album):**
```
   [Album Art]
     160x160
   [Album Name]
   [Artist]
```

### 4. Settings Pages

**Layout**: List with grouped sections

**Group Design:**
```dart
Container(
  decoration: BoxDecoration(
    color: surfaceVariant,
    borderRadius: BorderRadius.circular(12px),
  ),
  child: Column(
    children: [
      SettingTile(...),
      Divider(height: 1),
      SettingTile(...),
    ],
  ),
)
```

**Setting Tile:**
```
[Icon]  [Title, Description]  [Switch/Arrow]
 24px       flexible              32px
```

## Animation System

### Standard Easing Curves

```dart
// Fast out, slow in (entering)
curves.easeInCubic

// Fast out, slow in (exiting)
curves.easeOutCubic

// Smooth (default)
curves.easeInOut

// Bounce (playful interactions)
curves.elasticOut
```

### Standard Durations

```dart
durationFast: 150ms     // Hover, focus
durationNormal: 250ms   // Screen transitions
durationSlow: 350ms     // Complex animations
durationSlower: 500ms   // Hero animations
```

### Key Animations

1. **Mini Player → Full Player**
   - Type: Hero animation
   - Duration: 400ms
   - Curve: easeInOutCubic

2. **Song Change**
   - Album art: Crossfade (200ms)
   - Text: Slide in (150ms, staggered)
   - Progress bar: Animate to new position (300ms)

3. **Play/Pause**
   - Icon: Scale + rotate (200ms)
   - Button: Ripple effect (inherited)

4. **List Item Tap**
   - Scale down (95%, 100ms)
   - Scale up (100%, 100ms)
   - Navigate (150ms delay)

5. **Loading States**
   - Shimmer effect
   - Duration: 1500ms (infinite)

## Icons

### Icon Library

Using **Phosphor Icons** for modern, consistent iconography:

**Style**: Regular weight, 24px default

**Key Icons:**
- Play: `PhPlayCircle`
- Pause: `PhPauseCircle`
- Skip: `PhSkipForward`, `PhSkipBack`
- Shuffle: `PhShuffle`
- Repeat: `PhRepeat`
- Queue: `PhList`
- Heart: `PhHeart`
- Settings: `PhGear`
- Search: `PhMagnifyingGlass`
- Library: `PhBooks`
- Playlist: `PhPlaylist`

### Icon Usage Rules

- 24px for standard icons
- 32px for FABs and prominent actions
- 48px for empty states
- Use fill variant for active states

## Gesture Guidelines

### Tap

- Minimum tap target: 44x44px
- Visual feedback: Ripple effect
- Duration: Instant response

### Swipe

- Mini player: Up to expand, down to dismiss
- List items: Swipe for actions (remove, add to queue)
- Threshold: 80px to trigger action

### Long Press

- List items: Show context menu
- Album art: Large preview
- Feedback: Haptic vibration (if supported)

### Pinch

- Album art: Zoom in (up to 2x)
- Minimum scale: 1.0
- Maximum scale: 2.0

## Responsive Design

### Breakpoints

```dart
// Mobile
mobile: < 600px

// Tablet
tablet: 600px - 840px

// Desktop
desktop: > 840px
```

### Layout Adaptations

**Mobile (< 600px)**:
- Bottom navigation
- Single column lists
- Full-screen player takes entire screen

**Tablet (600px - 840px)**:
- Side navigation rail
- Two column lists where appropriate
- Full-screen player: Side panel (400px) + Content

**Desktop (> 840px)**:
- Side navigation drawer (240px)
- Multi-column content
- Full-screen player: Modal or dedicated view

## Accessibility

### Minimum Standards

- Touch targets: 44x44px minimum
- Color contrast: WCAG AA (4.5:1 for body text)
- Font scaling: Support up to 200%
- Screen reader: Semantic labels for all interactive elements
- Keyboard navigation: All features accessible via keyboard

### Semantic Labels

```dart
Semantics(
  button: true,
  label: 'Play',
  hint: 'Play the current song',
  child: IconButton(
    icon: Icon(Icons.play),
    onPressed: _play,
  ),
)
```

## Platform-Specific Adaptations

### Android

- Material Design 3 components
- Back navigation using system back button
- Notifications for playback control
- Picture-in-picture support (future)

### Windows

- Fluent UI components where appropriate
- Title bar integration
- System media transport controls
- Keyboard shortcuts (Space, Arrow keys, Ctrl+P, etc.)

### Linux

- GTK style for dialogs
- System tray integration
- MPRIS support for media keys

## Design Tokens (Reference)

All design values are defined as constants in `lib/core/theme/design_tokens.dart`:

```dart
class DesignTokens {
  // Spacing
  static const double spacing2 = 8.0;
  static const double spacing4 = 16.0;
  static const double spacing6 = 24.0;

  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Elevation
  static const double elevationNone = 0.0;
  static const double elevationSubtle = 2.0;
  static const double elevationMedium = 8.0;
  static const double elevationHigh = 16.0;

  // Duration
  static const int durationFast = 150;
  static const int durationNormal = 250;
  static const int durationSlow = 350;
}
```

## Future Enhancements

1. **Dynamic Island** - Adapt to Dynamic Island on iOS
2. **Theme Store** - User-created color themes
3. **Customizable Layout** - Drag-and-drop UI elements
4. **Gesture Customization** - User-defined gestures
5. **Animation Preferences** - Reduce motion option
