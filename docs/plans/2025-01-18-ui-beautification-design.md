# UI Beautification Design Document

> **For Claude:** This is the design document for UI beautification. Use superpowers:writing-plans to create implementation plan from this design.

**Goal:** Beautify the Echo Music app UI with Neumorphism/Minimalist style across player page, home/discovery page, and micro-interactions.

**Date:** 2025-01-18

---

## Design Style: Neumorphism / Minimalist

- **Soft shadows**: Dual shadows (light + dark) for raised/inset effects
- **Large border radius**: 16-24px for consistency
- **Low saturation colors**: Reduce visual fatigue
- **Subtle gradients**: Not high contrast, gentle transitions

---

## 1. Theme Updates

**File:** `lib/core/theme/app_theme.dart`

**Dark Mode Adjustments:**
- Background: `#0A0A0B` → `#12141A` (better for shadow display)
- Surface: Keep `#121214`
- Surface Variant: `#1C1C1E`

**Neumorphic Shadows (Dark Mode):**
- Raised: `box-shadow: 8px 8px 16px #0a0b0e, -8px -8px 16px #1a1d26`
- Inset: `box-shadow: inset 4px 4px 8px #0a0b0e, inset -4px -4px 8px #1a1d26`
- Button pressed: `box-shadow: inset 2px 2px 4px #0a0b0e, inset -2px -2px 4px #1a1d26`

**Light Mode Adjustments:**
- Background: Keep `#FAFAFA`
- Raised: `box-shadow: 6px 6px 12px #e0e0e0, -6px -6px 12px #ffffff`
- Inset: `box-shadow: inset 3px 3px 6px #e0e0e0, inset -3px -3px 6px #ffffff`

**Border Radius Updates:**
- Small: 8px → 12px
- Medium: 12px → 16px
- Large: 16px → 20px
- XLarge: 24px → 28px

---

## 2. Player Page Design

**File:** `lib/presentation/pages/full_player_page.dart`

### Album Art Area
- Add soft glow effect based on song's accent color (blur radius: 30px, opacity: 0.3)
- Subtle breathing animation: scale 1.0 ↔ 1.02, 4-second loop
- Cover border radius: 24px
- Neumorphic raised shadow

### Progress Bar
- Track: Neumorphic inset effect
- Slider: Circular with accent color glow
- Played portion: Gradient from accent color to lighter shade

### Control Buttons
- Main play button: Neumorphic raised + accent gradient background
- Secondary buttons (prev/next): Pure neumorphic, no fill
- Pressed state: Inset effect (150ms animation)

### Background
- Blurred album art as background (10% opacity)
- Semi-transparent gradient overlay

---

## 3. Home/Discovery Page Design

**File:** `lib/presentation/pages/home_page.dart`

### Quick Actions Grid
- Neumorphic raised card style
- Icons: subtle hover animation (translateY(-2px))
- Background: subtle gradient

### Recently Played Cards
- Unified border radius: 20px
- Play count badge (top-right, semi-transparent background)
- Press effect on tap

### Made For You Section
- Keep gradient cards but optimize for gentle transitions
- Increased card height
- "Play All" floating button

### Bottom Navigation
- Frosted glass effect (blur 10px, 0.8 opacity)
- Accent color dot indicator for active tab
- Active icon: slight scale up (1.1)

### List Items
- Padding: 16px
- Divider replaced with 8px spacing
- Hover: card lifts up + shadow deepens

---

## 4. Micro-Interactions

**Animation Durations (update in theme):**
- Fast: 150ms → 120ms
- Normal: 250ms → 200ms
- Slow: 350ms → 300ms
- Slower: 500ms → 400ms

### Button Interactions
- All clickable: pressed → scale(0.96) + inset shadow
- Ripple: Accent color, 20% opacity
- Hover: translateY(-2px)

### Page Transitions
- Page switch: Shared Axis transition
- Fade: 200ms easing curve
- Element entry: Staggered animation (50ms delay per item)

### Player Expand Animation
- MiniPlayer → FullPlayer: Corner morph animation (400ms)
- Album art: 48px → full size
- Background blur: 0 → 20px

### Loading States
- Skeleton screen: Neumorphic style (light gray raised)
- Loading indicator: Three dots pulse animation

### Haptic Feedback
- Important actions: Light vibration (play, favorite)
- Settings toggle to enable/disable

---

## 5. Implementation Priority

1. **Phase 1: Theme Foundation** - Update theme file with neumorphic tokens
2. **Phase 2: Player Page** - Apply new styles to full player
3. **Phase 3: Home Page** - Update cards and navigation
4. **Phase 4: Animations** - Add micro-interactions and transitions

---

## Tech Stack

- Flutter 3.x
- Material 3
- Phosphor Icons (existing)
- Custom neumorphic widgets to be created
