import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';

import '../../../../core/styles/app_color.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({
    super.key,
    required this.showDivider,
    required this.image,
    required this.title,
    required this.value,
  });
  final bool showDivider;
  final String image;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.width * 0.15,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(image),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider) ...[
          const SizedBox(width: 16),
          Container(
            height: 64,
            width: 1,
            color: AppColors.grey.withOpacity(0.5),
          ),
          const SizedBox(width: 16),
        ]
      ],
    );
  }
}
