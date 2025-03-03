import 'package:flutter/material.dart';
import 'content_moderation/content_moderation.dart';
import 'dashboard_statistics/dashboard_statistics.dart';
import 'user_metrics/user_metrics.dart';

class DashBoardBody extends StatelessWidget {
  const DashBoardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: UserMetrics()),
            Expanded(child: ContentModeration()),
          ],
        ),
        DashboardStatistics()
      ],
    );
  }
}
