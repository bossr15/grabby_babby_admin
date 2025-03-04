import 'package:flutter/material.dart';

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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.lightBlue,
                    ),
                    child: Text(
                      "Approve",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.white,
                    ),
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
