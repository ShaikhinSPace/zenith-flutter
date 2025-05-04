import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:injectable/injectable.dart';
import 'package:zenith/core/route/go_route_config.dart';

@lazySingleton
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // BuildContext? get ctx => getNavigationContext();
  static BuildContext? get ctx =>
      GoRouterConfig().routes.routerDelegate.navigatorKey.currentContext;

  /// This method is used to navigate to a new screen.
  void goTo(String routeName, {dynamic arguments}) {
    ctx?.pushNamed(routeName, extra: arguments);
  }

  /// This is used to pop the current route and navigate to previous route
  void pop([Object? data]) {
    ctx?.pop(data);
  }

  /// This will pops all the routes and navigates to new route
  /// It's like starting from fresh
  void clearStackAndGoTo(String route, {dynamic arguments}) {
    ctx?.goNamed(route, extra: arguments);
  }

  /// This will replace the current route with desired route
  void replaceLastRouteWithCurrentRoute(String route, {dynamic arguments}) {
    ctx?.replaceNamed(route, extra: arguments);
  }

  void popUntilRoute(String desiredRoute) {
    return navigatorKey.currentState!.popUntil((Route<dynamic> route) {
      return route.settings.name == desiredRoute;
    });
  }

  BuildContext? getNavigationContext() {
    return ctx;
  }

  bool canPop() {
    return ctx?.canPop() ?? false;
  }

  /// This will return all the routes in list
  /// It starts from initial route to the last route
  List<String> getRoutes() {
    var matches =
        GoRouterConfig().routes.routerDelegate.currentConfiguration.matches;

    List<String> routes = [];

    for (var match in matches) {
      routes.add((match.route as GoRoute).name ?? "");
    }

    debugPrint("routes: $routes");
    return routes;
  }
}
