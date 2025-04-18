import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../initializer.dart';
import '../presentation/view/analytics/analytics_screen.dart';
import '../presentation/view/app_orchestrator/app_orchestrator.dart';
import '../presentation/view/auth/login/login_view.dart';
import '../presentation/view/content_management/content_screen.dart';
import '../presentation/view/dashboard/dashboard.dart';
import '../presentation/view/g_b_admin.dart';
import '../presentation/view/home/home_page.dart';
import '../presentation/view/notifications/notifications_screen.dart';
import '../presentation/view/settings/settings_screen.dart';
import '../presentation/view/support/support_screen.dart';
import '../presentation/view/transaction_management/transaction_management.dart';
import '../presentation/view/user_management/components/user_details/user_details.dart';
import '../presentation/view/user_management/user_management.dart';
import 'route_name.dart';
import 'transition_route.dart' as troute;

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      troute.TransitionRoute.fadeTransitionRoute(
        path: '/',
        redirect: (context, state) {
          final token = localStorage.getString("token");
          if (token != null && token.isNotEmpty) return '/dashboard';
          return '/login';
        },
        name: RouteName.appOrchestrator,
        pageBuilder: (context, state) => const AppOrchestrator(),
      ),
      troute.TransitionRoute.fadeTransitionRoute(
        path: '/login',
        shouldRedirect: false,
        name: RouteName.login,
        pageBuilder: (context, state) => const LoginView(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomePage(child: child);
        },
        routes: [
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/dashboard',
            name: RouteName.dashboard,
            pageBuilder: (context, state) => const Dashboard(),
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/users',
            name: RouteName.users,
            pageBuilder: (context, state) => const UserManagement(),
            routes: [
              troute.TransitionRoute.fadeTransitionRoute(
                path: '/user-details',
                name: RouteName.userDetails,
                pageBuilder: (context, state) {
                  final accountType = state.extra as String? ??
                      localStorage.getString('accountType') ??
                      "";
                  return UserDetails(
                    accountType: accountType,
                  );
                },
              ),
            ],
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/transaction',
            name: RouteName.transactions,
            pageBuilder: (context, state) => const TransactionManagement(),
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/analytics',
            name: RouteName.analytics,
            pageBuilder: (context, state) => const AnalyticsScreen(),
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/content',
            name: RouteName.contentManagement,
            pageBuilder: (context, state) => const ContentScreen(),
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/notifications',
            name: RouteName.notifications,
            pageBuilder: (context, state) => const NotificationsScreen(),
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/support',
            name: RouteName.supportManagement,
            pageBuilder: (context, state) => const SupportScreen(),
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/settings',
            name: RouteName.settings,
            pageBuilder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      );
    },
  );
}
