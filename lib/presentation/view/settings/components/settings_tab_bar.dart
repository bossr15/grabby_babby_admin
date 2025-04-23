import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';

class SettingsTabBar extends StatelessWidget {
  const SettingsTabBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: AppColors.darkBlue,
      unselectedLabelColor: AppColors.grey,
      dividerColor: AppColors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColors.darkBlue,
      tabs: [
        Tab(text: "Account Setting"),
        Tab(text: "Login & Security"),
      ],
    );
  }
}
