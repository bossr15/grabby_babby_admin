import 'package:flutter/material.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';
import 'dashboard_stats_card.dart';

class DashBoardStats extends StatelessWidget {
  const DashBoardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardStatsCard(
                image: AppImages.totalUsers,
                title: 'Total Users',
                value: '5,423',
                showDivider: true,
              ),
              DashboardStatsCard(
                image: AppImages.buyers,
                title: 'Buyers',
                value: '1,423',
                showDivider: true,
              ),
              DashboardStatsCard(
                image: AppImages.sellers,
                title: 'Sellers',
                value: '1,893',
                showDivider: true,
              ),
              DashboardStatsCard(
                image: AppImages.businessSellers,
                title: 'Business Sellers',
                value: '1,893',
                showDivider: true,
              ),
              DashboardStatsCard(
                image: AppImages.pendingApproval,
                title: 'Pending Approval',
                value: '189',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
