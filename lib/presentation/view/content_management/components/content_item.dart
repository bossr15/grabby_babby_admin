import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/data/models/notification_model/notification_model.dart';

import '../../../../core/styles/app_images.dart';

class ContentItem extends StatelessWidget {
  const ContentItem({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            isThreeLine: true,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(AppImages.dummyUser),
            ),
            title: Text('${notification.title}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '${notification.message}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Text(
                //     DateHelpers.formatStringDate(notification.createdAt ?? "")),
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: ListTile(
        //     leading: ClipRRect(
        //       borderRadius: BorderRadius.circular(12),
        //       child: Image.asset(
        //         [
        //           AppImages.productImage1,
        //           AppImages.productImage2,
        //           AppImages.productImage3,
        //           AppImages.productImage4
        //         ][Random().nextInt(4)],
        //       ),
        //     ),
        //     title: Text('Product Name'),
        //     subtitle: Text('Lorem ipsum dolor sit amet...'),
        //   ),
        // ),
      ],
    );
  }
}
