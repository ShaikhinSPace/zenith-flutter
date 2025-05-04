import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> fadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    name: state.name,
    child: child,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) => FadeTransition(opacity: animation, child: child),
  );
}

CustomTransitionPage<T> scaleTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    name: state.pageKey.value,
    child: child,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) => ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
          ),
          child: child,
        ),
  );
}

CustomTransitionPage<T> slideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    name: state.pageKey.value,
    child: child,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

CustomTransitionPage<T> toTheTopTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    name: state.name,
    child: child,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) => Stack(
          children: <Widget>[
            FadeTransition(opacity: animation),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0), // Slide from bottom
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ],
        ),
  );
}

CustomTransitionPage<T> fluidSlideTransitionFromHole<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    name: state.pageKey.value,
    child: child,
    transitionDuration: const Duration(milliseconds: 800),
    reverseTransitionDuration: const Duration(milliseconds: 700),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      // Using a fluid curve for smoother easing in and out.
      final CurvedAnimation fluidAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      );

      // Fade transition: the page gradually appears.
      final Animation<double> fadeTransition = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(fluidAnimation);

      // Scale transition: the page scales up from 0 to its full size,
      // anchored at the bottom to simulate emerging from a hole.
      final Animation<double> scaleTransition = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(fluidAnimation);

      // Slide transition: a subtle upward slide enhances the effect.
      final Animation<Offset> slideTransition = Tween<Offset>(
        begin: const Offset(0.0, 0.2), // Slightly below its final position.
        end: Offset.zero,
      ).animate(fluidAnimation);

      return FadeTransition(
        opacity: fadeTransition,
        child: SlideTransition(
          position: slideTransition,
          child: ScaleTransition(
            alignment: Alignment.bottomCenter,
            scale: scaleTransition,
            child: child,
          ),
        ),
      );
    },
  );
}

CustomTransitionPage<T> circleFillsScreenTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required Offset tapPosition,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      final Size size = MediaQuery.of(context).size;
      final double dx = max(tapPosition.dx, size.width - tapPosition.dx);
      final double dy = max(tapPosition.dy, size.height - tapPosition.dy);
      final double maxRadius = sqrt(dx * dx + dy * dy);

      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return ClipPath(
            clipper: CircularRevealClipper(
              center: tapPosition,
              radius: animation.value * maxRadius,
            ),
            child: child,
          );
        },
        child: child,
      );
    },
  );
}

class CircularRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircularRevealClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return radius != oldClipper.radius || center != oldClipper.center;
  }
}
