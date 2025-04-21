import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final _appContext = navigatorKey.currentState!.context;
  static void pushNamed(
    String routeName, {
    dynamic extra,
  }) {
    _appContext.goNamed(routeName, extra: extra);
  }

  static void pushReplacementNamed(
    String routeName, {
    dynamic extra,
  }) {
    _appContext.replaceNamed(routeName, extra: extra);
  }

  static void pop() {
    _appContext.pop();
  }
}
