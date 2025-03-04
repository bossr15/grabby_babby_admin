import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/widgets/g_b_admin_button.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(AppImages.lighting),
              const SizedBox(width: 10),
              Text("New Account Created"),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          isThreeLine: true,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(AppImages.dummyUser),
          ),
          title: Text('Lex Murphy Register business account  D Game Heaven'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  GbAdminButton(
                    label: "Approve",
                    onPressed: () {},
                    backgroundColor: AppColors.lightBlue,
                    textColor: AppColors.white,
                  ),
                  const SizedBox(width: 10),
                  GbAdminButton(
                    label: "Decline",
                    onPressed: () {},
                    backgroundColor: AppColors.white,
                    textColor: AppColors.black,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Today at 9:42 AM"),
            ],
          ),
        ),
      ],
    );
  }
}
