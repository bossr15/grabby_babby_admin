import 'package:flutter/material.dart';

import '../../../../../core/styles/app_color.dart';
import 'users_table/users_table.dart';

class UsersTabView extends StatelessWidget {
  const UsersTabView({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        UsersTable(
            status: "Active",
            statusColor: AppColors.green,
            statusTextColor: AppColors.greenText),
        UsersTable(
            status: "Pending",
            statusColor: AppColors.yellow,
            statusTextColor: AppColors.yellowText),
        UsersTable(
            status: "Suspended",
            statusColor: AppColors.red,
            statusTextColor: AppColors.redText),
      ],
    );
  }
}
