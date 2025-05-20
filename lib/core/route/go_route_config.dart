import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zenith/core/api_service.dart/api_service.dart';
import 'package:zenith/core/route/routes.dart';
import 'package:zenith/core/transition/transition_config.dart';
import 'package:zenith/core/transition/transitions.dart';
import 'package:zenith/features/home/home.dart';
import 'package:zenith/features/session/session_screen.dart';
import 'package:zenith/features/settings/settings.dart';

class GoRouterConfig {
  GoRouterConfig._();

  static final GoRouterConfig _instance = GoRouterConfig._();

  factory GoRouterConfig() {
    return _instance;
  }

  // Modified _goRoute method to support custom transitions
  static GoRoute _goRoute<T>({
    required String path,
    required Widget child,
    GoRouterWidgetBuilder? builder,
    List<RouteBase>? routes,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    GoRouterPageBuilder? pageBuilder,
  }) {
    return GoRoute(
      path: path,
      name: path,
      builder: builder,
      routes: routes ?? <RouteBase>[],
      parentNavigatorKey: parentNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state) {
        // Use Flutter's default transition if no TransitionConfig is provided
        if (state.extra is! TransitionConfig) {
          return MaterialPage(key: state.pageKey, child: child);
        }

        final TransitionConfig transitionData = state.extra as TransitionConfig;

        switch (transitionData.transitionType) {
          case TransitionType.circularReveal:
            final Offset tapPosition =
                transitionData.tapPosition ??
                Offset(
                  MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 2,
                );
            return circleFillsScreenTransition(
              context: context,
              state: state,
              child: child,
              tapPosition: tapPosition,
            );
          case TransitionType.toTheTop:
            return toTheTopTransition(
              context: context,
              state: state,
              child: child,
            );
          case TransitionType.slide:
            return slideTransition(
              context: context,
              state: state,
              child: child,
            );
          default:
            return fadeTransition(context: context, state: state, child: child);
        }
      },
    );
  }

  late final GoRouter _routes;

  Future<void> init() async {
    // final isAuth = await GlobalServices().isUserAuthenticated();

    _routes = GoRouter(
      initialLocation: Routes.homeRoute,
      errorBuilder:
          (context, state) =>
              Scaffold(body: Center(child: Text('Route not found'))),
      routes: [
        _goRoute(path: Routes.homeRoute, child: HomeScreen()),
        _goRoute(path: Routes.settings, child: SettingsScreen()),
        _goRoute(path: Routes.replyToChatScreen, child: AiScheduleScreen()),
        _goRoute(path: Routes.sessionScreen, child: SessionScreen()),
      ],
    );
  }

  GoRouter get routes => _routes;
}
