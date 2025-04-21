import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dashboard_statistics/dashboard_statistics.dart';
import 'user_metrics/user_metrics.dart';

class DashBoardBody extends StatelessWidget {
  const DashBoardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [UserMetrics(), Gap(20), DashboardStatistics()],
    );
  }
}
