import 'package:flutter/material.dart';
import '../../../../../core/styles/app_color.dart';
import '../../../../../core/styles/app_images.dart';

class GBAdminAppBar extends StatelessWidget {
  const GBAdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text(
            'Hello Super Admin 👋',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.black,
            ),
          ),
          const Spacer(),
          Image.asset(
            AppImages.appBarNotification,
          ),
          const SizedBox(width: 16),
          Image.asset(
            AppImages.dummyUser,
          ),
        ],
      ),
    );
  }
}
