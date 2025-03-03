import 'package:flutter/material.dart';

import 'components/dashboard_body.dart';
import 'components/dashboard_card.dart';
import 'components/dashboard_pending_accounts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              DashboardCard(title: 'Total Earning', value: '\$41646'),
              DashboardCard(title: 'Total Buyers', value: '\$1123'),
              DashboardCard(title: 'Total Sellers', value: '\$134'),
              DashboardCard(title: 'Suspended Users', value: '\$134'),
              DashBoardPendingAccounts(requests: '235'),
            ],
          ),
          DashBoardBody(),
        ],
      ),
    );
  }
}
