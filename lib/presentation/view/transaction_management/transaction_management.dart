import 'package:flutter/material.dart';

import '../../../core/styles/app_color.dart';

class TransactionManagement extends StatelessWidget {
  const TransactionManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            children: [],
          ),
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
