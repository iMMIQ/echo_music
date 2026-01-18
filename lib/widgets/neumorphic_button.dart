import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Style options for NeumorphicButton
enum NeumorphicButtonStyle {
  /// Filled button with gradient background
  filled,

  /// Outlined button with transparent background and border
  outlined,

  /// Tonal button with accent color and opacity
  tonal,
}

/// A neumorphic button with press animation and configurable styles.
///
/// The button supports three visual styles:
/// - `NeumorphicButtonStyle.filled`: Gradient background with accent color
/// - `NeumorphicButtonStyle.outlined`: Transparent background with border
/// - `NeumorphicButtonStyle.tonal`: Accent color with reduced opacity
///
/// Example:
/// ```dart
/// NeumorphicButton(
///   onPressed: () => print('Pressed'),
///   style: NeumorphicButtonStyle.filled,
///   child: Icon(Icons.play_arrow),
/// )
/// ```
class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    required this.child,
    required this.onPressed,
    super.key,
    this.style = NeumorphicButtonStyle.filled,
    this.accentColor,
    this.width,
    this.height,
    this.iconSize,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Callback when the button is tapped or activated.
  final VoidCallback? onPressed;

  /// The visual style of the button.
  final NeumorphicButtonStyle style;

  /// Optional accent color. If not provided, uses theme's primary color.
  final Color? accentColor;

  /// Optional fixed width for the button.
  final double? width;

  /// Optional fixed height for the button.
  final double? height;

  /// Optional size for child icons.
  final double? iconSize;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: DesignTokens.durationFast),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.96).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shadows = isDark ? neumorphicDark : neumorphicLight;

    final accentColor = widget.accentColor ?? theme.colorScheme.primary;
    final buttonColor = widget.onPressed == null
        ? theme.colorScheme.onSurface.withValues(alpha: 0.38)
        : accentColor;

    // Get shadows based on press state
    List<BoxShadow> getShadows() {
      if (_isPressed) return shadows.buttonPressed;
      return shadows.raised;
    }

    // Get background based on style
    Decoration getDecoration() {
      final borderRadius = BorderRadius.circular(DesignTokens.radiusMedium);

      switch (widget.style) {
        case NeumorphicButtonStyle.filled:
          return BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.onPressed == null
                  ? [
                      theme.disabledColor.withValues(alpha: 0.3),
                      theme.disabledColor.withValues(alpha: 0.1),
                    ]
                  : [
                      buttonColor.withValues(alpha: 0.9),
                      buttonColor.withValues(alpha: 0.7),
                    ],
            ),
            borderRadius: borderRadius,
            boxShadow: getShadows(),
          );

        case NeumorphicButtonStyle.outlined:
          return BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(
              color: widget.onPressed == null
                  ? theme.disabledColor.withValues(alpha: 0.3)
                  : buttonColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
            borderRadius: borderRadius,
            boxShadow: getShadows(),
          );

        case NeumorphicButtonStyle.tonal:
          return BoxDecoration(
            color: widget.onPressed == null
                ? theme.disabledColor.withValues(alpha: 0.1)
                : buttonColor.withValues(alpha: 0.15),
            borderRadius: borderRadius,
            boxShadow: getShadows(),
          );
      }
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: DesignTokens.durationFast),
          width: widget.width,
          height: widget.height,
          decoration: getDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing4,
              vertical: DesignTokens.spacing3,
            ),
            child: Center(
              child: IconTheme.merge(
                data: IconThemeData(
                  size: widget.iconSize,
                  color: widget.style == NeumorphicButtonStyle.filled
                      ? Colors.white
                      : buttonColor,
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
