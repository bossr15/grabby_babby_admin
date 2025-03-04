import 'package:flutter/material.dart';
import '../../dashboard/components/dashboard_card.dart';

class AnalyticsCards extends StatelessWidget {
  const AnalyticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            DashboardCard(title: 'Active Users', value: '127'),
            DashboardCard(title: 'Account Created', value: '298'),
            DashboardCard(title: 'Product Listing', value: '355'),
          ],
        ),
        Row(
          children: const [
            DashboardCard(title: 'Product Purchased', value: '234'),
            DashboardCard(title: 'Earnings', value: '\$1324'),
            DashboardCard(title: 'Violated Content', value: '334'),
          ],
        ),
      ],
    );
  }
}
