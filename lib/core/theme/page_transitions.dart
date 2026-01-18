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

class SlideUpPageTransition<T> extends PageRouteBuilder<T> {
  SlideUpPageTransition({
    required this.child,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0, 0.1);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(tween),
                child: child,
              ),
            );
          },
        );

  final Widget child;
}
