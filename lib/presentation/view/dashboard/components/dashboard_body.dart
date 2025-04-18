import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../logic/dashboard/dashboard_cubit.dart';
import 'dashboard_statistics/dashboard_statistics.dart';
import 'user_metrics/user_metrics.dart';

class DashBoardBody extends StatelessWidget {
  const DashBoardBody({super.key, required this.cubit});
  final DashboardCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Expanded(child: UserMetrics()),
        //     Expanded(child: ContentModeration()),
        //   ],
        // ),
        UserMetrics(cubit: cubit),
        Gap(20),
        DashboardStatistics(cubit: cubit)
      ],
    );
  }
}
