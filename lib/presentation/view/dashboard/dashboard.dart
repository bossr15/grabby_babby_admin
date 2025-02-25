import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';

import 'components/dashboard_body.dart';
import 'components/dashboard_stats.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashBoardStats(),
        SizedBox(
          height: context.height * 0.7,
          width: context.width,
          child: DashBoardBody(),
        ),
      ],
    );
  }
}
