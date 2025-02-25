import 'package:flutter/material.dart';

import '../../../../core/styles/app_color.dart';

class DashBoardBody extends StatelessWidget {
  const DashBoardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
          Text('User Management'),
        ],
      ),
    );
  }
}
