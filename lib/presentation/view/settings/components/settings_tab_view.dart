import 'package:flutter/material.dart';

import 'account_settings/account_settings.dart';
import 'login_security/login_security.dart';
import 'notification_settings/notification_settings.dart';

class SettingsTabView extends StatelessWidget {
  const SettingsTabView({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        AccountSettings(),
        LoginSecurity(),
        NotificationSettings(),
      ],
    );
  }
}
