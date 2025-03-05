import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';
import 'user_stats_card.dart';

class UserStats extends StatelessWidget {
  const UserStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: context.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            UserStatsCard(
              image: AppImages.totalUsers,
              title: 'Total Users',
              value: '5,423',
            ),
            _spacerDivider,
            UserStatsCard(
              image: AppImages.buyers,
              title: 'Buyers',
              value: '1,423',
            ),
            _spacerDivider,
            UserStatsCard(
              image: AppImages.sellers,
              title: 'Sellers',
              value: '1,893',
            ),
            _spacerDivider,
            UserStatsCard(
              image: AppImages.businessSellers,
              title: 'Business Sellers',
              value: '1,893',
            ),
            _spacerDivider,
            UserStatsCard(
              image: AppImages.pendingApproval,
              title: 'Pending Approval',
              value: '189',
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget get _spacerDivider => Expanded(
        child: Row(
          children: [
            Spacer(),
            Container(
              height: 64,
              width: 1,
              color: AppColors.grey.withOpacity(0.5),
            ),
            Spacer(),
          ],
        ),
      );
}
