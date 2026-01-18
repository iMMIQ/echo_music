import 'package:flutter/material.dart';

class StaggeredAnimationList extends StatelessWidget {
  const StaggeredAnimationList({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.delay = const Duration(milliseconds: 50),
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;
  final Duration delay;

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
  const _StaggeredItem({
    required this.index,
    required this.delay,
    required this.duration,
    required this.child,
  });

  final int index;
  final Duration delay;
  final Duration duration;
  final Widget child;

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

    _slideAnimation = Tween<double>(begin: .1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
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
