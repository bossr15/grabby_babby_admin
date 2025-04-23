import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/data/models/notification_model/notification_model.dart';
import 'components/content_header.dart';
import 'components/content_item.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            ContentHeader(),
            Expanded(
                child: ListView.separated(
              itemBuilder: (context, index) =>
                  ContentItem(notification: NotificationModel()),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 12,
            ))
          ],
        ),
      ),
    );
  }
}
