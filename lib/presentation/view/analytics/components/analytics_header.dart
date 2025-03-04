import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Analytics and Reporting',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.download),
                const SizedBox(width: 10),
                Text('Download'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(),
        const SizedBox(height: 15),
        Container(
          width: 250,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Text('Timeframe: x '),
              Text(
                'Month to x Month',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }
}
