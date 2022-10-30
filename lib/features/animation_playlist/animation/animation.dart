import 'package:flutter/material.dart';

import 'animation_manager.dart';

Route createFadeInRoute({required RoutePageBuilder routePageBuilder}) {
  return PageRouteBuilder(
    transitionDuration: AnimationManager.routeTransitionDuration,
    reverseTransitionDuration: AnimationManager.routeTransitionDuration,
    pageBuilder: routePageBuilder,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}