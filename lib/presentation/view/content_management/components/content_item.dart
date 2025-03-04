import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/styles/app_images.dart';

class ContentItem extends StatelessWidget {
  const ContentItem({super.key});

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
            title: Text('Denise Nedry Reported review to D Game Heaven'),
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
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text('Last Wednesday at 9:42 AM'),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                [
                  AppImages.productImage1,
                  AppImages.productImage2,
                  AppImages.productImage3,
                  AppImages.productImage4
                ][Random().nextInt(4)],
              ),
            ),
            title: Text('Product Name'),
            subtitle: Text('Lorem ipsum dolor sit amet...'),
          ),
        ),
      ],
    );
  }
}
