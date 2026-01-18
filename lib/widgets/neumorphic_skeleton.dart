import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// A single neumorphic skeleton loading item with shimmer animation.
class NeumorphicSkeleton extends StatefulWidget {
  const NeumorphicSkeleton({
    required this.width,
    required this.height,
    this.borderRadius,
    super.key,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<NeumorphicSkeleton> createState() => _NeumorphicSkeletonState();
}

class _NeumorphicSkeletonState extends State<NeumorphicSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isDark
                ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: _animation.value)
                : Colors.grey.withValues(alpha: _animation.value),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(DesignTokens.radiusMedium),
            boxShadow: isDark
                ? neumorphicDark.raised
                : neumorphicLight.raised,
          ),
        );
      },
    );
  }
}

/// A list of skeleton items for displaying loading state in song lists.
class SongListSkeleton extends StatelessWidget {
  const SongListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, unused) => const SizedBox(height: 8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          ),
          child: Row(
            children: [
              const NeumorphicSkeleton(width: 56, height: 56),
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
