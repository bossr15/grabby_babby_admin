import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/view/content_management/components/content_item.dart';

import '../../../core/styles/app_color.dart';
import 'components/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notification",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) =>
                  index > 1 ? ContentItem() : NotificationItem(),
            )),
          ],
        ),
      ),
    );
  }
}
