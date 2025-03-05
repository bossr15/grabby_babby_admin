import 'package:flutter/material.dart';

import '../../../../core/styles/app_color.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({
    super.key,
    required this.image,
    required this.title,
    required this.value,
  });
  final String image;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
