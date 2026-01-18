import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class NeumorphicCard extends StatelessWidget {
  const NeumorphicCard({
    required this.child,
    super.key,
    this.isInset = false,
    this.isPressed = false,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final bool isInset;
  final bool isPressed;
  final EdgeInsetsGeometry padding;
  final double? borderRadius;
  final VoidCallback? onTap;

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
        borderRadius: BorderRadius.circular(borderRadius ?? DesignTokens.radiusMedium),
        boxShadow: getShadows(),
      ),
      child: onTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(borderRadius ?? DesignTokens.radiusMedium),
                child: child,
              ),
            )
          : child,
    );
  }
}
