import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grabby_babby_admin/presentation/logic/dashboard/dashboard_cubit.dart';

import '../../logic/dashboard/dashboard_state.dart';
import 'components/dashboard_body.dart';
import 'components/dashboard_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final headerStats = state.dashboardStats.headerStats;
          return SingleChildScrollView(
            child: Column(
              children: [
                Gap(20),
                Row(
                  children: [
                    DashboardCard(
                        title: 'Total Earning',
                        value:
                            '\$${headerStats.totalEarnings.toStringAsFixed(2)}'),
                    Gap(20),
                    DashboardCard(
                        title: 'Total Users',
                        value: '${headerStats.totalUserCounts}'),
                    Gap(20),
                    DashboardCard(
                        title: 'Total Buyers',
                        value: '${headerStats.buyerCounts}'),
                    Gap(20),
                    DashboardCard(
                        title: 'Total Sellers',
                        value: '${headerStats.sellerCounts}'),
                    Gap(20),
                    DashboardCard(
                        title: 'Suspended Users',
                        value: '${headerStats.suspendedCounts}'),
                  ],
                ),
                Gap(20),
                const DashBoardBody(),
              ],
            ),
          );
        },
      ),
    );
  }
}
