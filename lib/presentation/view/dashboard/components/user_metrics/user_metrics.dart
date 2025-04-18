import 'package:flutter/material.dart';

import '../../../../logic/dashboard/dashboard_cubit.dart';
import 'components/user_metrics_chart.dart';

class UserMetrics extends StatelessWidget {
  const UserMetrics({super.key, required this.cubit});
  final DashboardCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'User Metrics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Apr 30 - May 30',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const UserMetricsChart(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userMetricsItem('Total Registered Users', Colors.blue[200]!),
              const SizedBox(width: 24),
              userMetricsItem('Total Service Providers', Colors.green[200]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget userMetricsItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
