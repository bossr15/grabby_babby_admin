import 'package:flutter/material.dart';
import 'components/analytics_header.dart';
import 'components/analytics_cards.dart';
import 'components/analytics_table.dart';
import 'components/analytics_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnalyticsHeader(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: const AnalyticsCards()),
                const SizedBox(width: 10),
                Expanded(child: const AnalyticsChart()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: AnalyticsTable(
                    title: 'Buyers',
                    subtitle: 'Product Purchases',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AnalyticsTable(
                    title: 'Sellers',
                    subtitle: 'Product Listings',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
