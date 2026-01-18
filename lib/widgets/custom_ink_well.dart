import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    required this.child,
    super.key,
    this.onTap,
    this.borderRadius,
    this.splashColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final splash = splashColor ?? theme.colorScheme.primary.withValues(alpha: 0.2);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(DesignTokens.radiusMedium),
        splashColor: splash,
        highlightColor: splash.withValues(alpha: 0.5),
        child: child,
      ),
    );
  }
}
