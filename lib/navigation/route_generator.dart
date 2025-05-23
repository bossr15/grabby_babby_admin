import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/presentation/view/auth/forget_password/forget_password.dart';
import 'package:grabby_babby_admin/presentation/view/auth/new_password/new_password.dart';
import 'package:grabby_babby_admin/presentation/view/preferences/preferences_view.dart';
import 'package:grabby_babby_admin/presentation/view/subscription_plan/add_subscription_plan/add_subscription_plan.dart';
import 'package:grabby_babby_admin/presentation/view/subscription_plan/edit_subscription_plan/edit_subscription_plan.dart';
import 'package:grabby_babby_admin/presentation/view/subscription_plan/subscription_plan_view.dart';

import '../initializer.dart';
import '../presentation/view/analytics/analytics_screen.dart';
import '../presentation/view/app_orchestrator/app_orchestrator.dart';
import '../presentation/view/auth/login/login_view.dart';
import '../presentation/view/auth/verify_otp/verify_otp.dart';
import '../presentation/view/dashboard/dashboard.dart';
import '../presentation/view/home/home_page.dart';
import '../presentation/view/notifications/notifications_screen.dart';
import '../presentation/view/preferences/add_preferences/add_preferences.dart';
import '../presentation/view/preferences/edit_preferences/edit_preferences.dart';
import '../presentation/view/settings/settings_screen.dart';
import '../presentation/view/support/support_screen.dart';
import '../presentation/view/transaction_management/transaction_management.dart';
import '../presentation/view/user_management/components/user_details/user_details.dart';
import '../presentation/view/user_management/user_management.dart';
import 'route_name.dart';
import 'transition_route.dart' as troute;

class AppRouter {
  static final router = GoRouter(
    navigatorKey: AppNavigation.navigatorKey,
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
      troute.TransitionRoute.fadeTransitionRoute(
        path: '/forget-password',
        shouldRedirect: false,
        name: RouteName.forgetPassword,
        pageBuilder: (context, state) => const ForgetPassword(),
        routes: [
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/:email',
            shouldRedirect: false,
            name: RouteName.verifyOtp,
            pageBuilder: (context, state) {
              final email = state.pathParameters['email']!;
              return VerifyOtp(email: email);
            },
          ),
        ],
      ),
      troute.TransitionRoute.fadeTransitionRoute(
        path: '/new-password',
        shouldRedirect: false,
        name: RouteName.newPassword,
        pageBuilder: (context, state) => const NewPassword(),
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
                path: '/user-details/:id',
                name: RouteName.userDetails,
                pageBuilder: (context, state) {
                  final accountType = state.extra as String? ??
                      localStorage.getString('accountType') ??
                      "";
                  final userId = state.pathParameters['id']!;
                  return UserDetails(
                    userId: userId,
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
            path: '/preferences',
            name: RouteName.preferences,
            pageBuilder: (context, state) => const PreferencesView(),
            routes: [
              troute.TransitionRoute.fadeTransitionRoute(
                path: '/addPreferences',
                name: RouteName.addPreferences,
                pageBuilder: (context, state) => const AddPreferences(),
              ),
              troute.TransitionRoute.fadeTransitionRoute(
                path: '/:id',
                name: RouteName.editPreferences,
                pageBuilder: (context, state) {
                  return EditPreferences(id: state.pathParameters['id']!);
                },
              ),
            ],
          ),
          troute.TransitionRoute.fadeTransitionRoute(
            path: '/plans',
            name: RouteName.subscriptionPlan,
            pageBuilder: (context, state) => const SubscriptionPlanView(),
            routes: [
              troute.TransitionRoute.fadeTransitionRoute(
                path: '/addPlan',
                name: RouteName.addSubscriptionPlan,
                pageBuilder: (context, state) => const AddSubscriptionPlan(),
              ),
              troute.TransitionRoute.fadeTransitionRoute(
                path: '/:id',
                name: RouteName.editSubscriptionPlan,
                pageBuilder: (context, state) {
                  return EditSubscriptionPlan(id: state.pathParameters['id']!);
                },
              ),
            ],
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
