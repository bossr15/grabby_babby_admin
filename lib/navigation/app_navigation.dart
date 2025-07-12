import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart' as html;

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final _appContext = navigatorKey.currentState!.context;

  static void pushNamed(
    String routeName, {
    dynamic extra,
    Map<String, String>? pathParameters,
  }) {
    _appContext.pushNamed(routeName,
        extra: extra, pathParameters: pathParameters ?? {});
  }

  static Future<T?> pushNamedWithResult<T>(
    String routeName, {
    dynamic extra,
    Map<String, String>? pathParameters,
  }) async {
    return _appContext.pushNamed<T>(
      routeName,
      extra: extra,
      pathParameters: pathParameters ?? {},
    );
  }

  static void popUntil(
    String routeName, {
    dynamic extra,
    Map<String, String>? pathParameters,
  }) {
    _appContext.goNamed(routeName,
        extra: extra, pathParameters: pathParameters ?? {});
  }

  static void pushReplacementNamed(
    String routeName, {
    dynamic extra,
    Map<String, String>? pathParameters,
  }) {
    _appContext.replaceNamed(routeName,
        extra: extra, pathParameters: pathParameters ?? {});
  }

  static void pop<T>([T? result]) {
    _appContext.pop(result);
  }

  static String getCurrentPathFromBrowser() {
    final location = html.window.location.href;
    final hashedPath = location.split('#');
    final path = hashedPath.length > 1 ? hashedPath[1] : location;
    return path;
  }

  static int getSidePanelIndexFromRoute() {
    final currentPath = getCurrentPathFromBrowser();
    if (currentPath.startsWith('/dashboard')) return 0;
    if (currentPath.startsWith('/users')) return 1;
    if (currentPath.startsWith('/products')) return 2;
    if (currentPath.startsWith('/transaction')) return 3;
    if (currentPath.startsWith('/analytics')) return 4;
    if (currentPath.startsWith('/preferences')) return 5;
    if (currentPath.startsWith('/plans')) return 6;
    if (currentPath.startsWith('/notifications')) return 7;
    if (currentPath.startsWith('/settings')) return 8;
    if (currentPath.startsWith('/support')) return 9;

    return 0;
  }
}
