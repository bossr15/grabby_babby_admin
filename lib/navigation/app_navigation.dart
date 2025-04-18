import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/view/g_b_admin.dart';

class AppNavigation {
  static final appContext = navigatorKey.currentState!.context;

  static void pushNamed(
    BuildContext context,
    String routeName, {
    dynamic extra,
  }) {
    appContext.goNamed(routeName, extra: extra);
  }

  static void pushReplacementNamed(
    BuildContext context,
    String routeName, {
    dynamic extra,
  }) {
    appContext.replaceNamed(routeName, extra: extra);
  }

  static void pop(BuildContext context) {
    appContext.pop();
  }
}
