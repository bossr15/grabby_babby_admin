import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grabby_babby_admin/presentation/logic/analytics/analytics_cubit.dart';
import '../../../logic/analytics/analytics_state.dart';
import '../../dashboard/components/dashboard_card.dart';

class AnalyticsCards extends StatelessWidget {
  const AnalyticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final counts = state.analytics.counts;
        return Column(
          children: [
            Row(
              children: [
                DashboardCard(
                    title: 'Active Users', value: '${counts.activeUserCount}'),
                Gap(10),
                DashboardCard(
                    title: 'Account Created',
                    value: '${counts.totalUsersCount}'),
                Gap(10),
                DashboardCard(
                    title: 'Product Listing', value: '${counts.productsCount}'),
              ],
            ),
            Gap(20),
            Row(
              children: [
                DashboardCard(
                    title: 'Product Purchased',
                    value: '${counts.productPurchaseCount}'),
                Gap(10),
                DashboardCard(
                    title: 'Earnings', value: '\$${counts.totalEarnings}'),
              ],
            ),
          ],
        );
      },
    );
  }
}
