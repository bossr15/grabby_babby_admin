import 'package:flutter/material.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "\$240,399",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "All Accounts",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildTransactionItem("\$250"),
          const SizedBox(height: 12),
          _buildTransactionItem("\$244"),
          const SizedBox(height: 12),
          _buildTransactionItem("\$344"),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.darkBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'View All',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Received",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        Row(
          children: [
            Text(
              amount,
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(AppImages.arrowUp),
          ],
        ),
      ],
    );
  }
}
