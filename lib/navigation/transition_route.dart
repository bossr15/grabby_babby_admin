import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grabby_babby_admin/initializer.dart';

class TransitionRoute {
  static GoRoute fadeTransitionRoute({
    required String path,
    required String? name,
    required Widget Function(BuildContext, GoRouterState) pageBuilder,
    bool shouldRedirect = true,
    String Function(BuildContext, GoRouterState)? redirect,
    List<RouteBase> routes = const <RouteBase>[],
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        child: pageBuilder(context, state),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeIn).animate(animation),
            child: child,
          );
        },
      ),
      routes: routes,
      redirect: redirect ??
          (shouldRedirect
              ? (context, state) {
                  final token = localStorage.getString("token");
                  if (token != null && token.isNotEmpty) return null;
                  return '/login';
                }
              : null),
    );
  }
}
