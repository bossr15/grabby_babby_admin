import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static void pushNamed(
    BuildContext context,
    String routeName, {
    dynamic extra,
  }) {
    context.goNamed(routeName, extra: extra);
  }

  static void pushReplacementNamed(
    BuildContext context,
    String routeName, {
    dynamic extra,
  }) {
    context.pushReplacementNamed(routeName, extra: extra);
  }

  static void pop(BuildContext context) {
    context.pop();
  }
}
