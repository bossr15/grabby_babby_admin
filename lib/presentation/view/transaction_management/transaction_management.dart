import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/view/transaction_management/components/total_balance.dart';

import '../../../core/styles/app_color.dart';
import 'components/categories_revenue.dart';
import 'components/recent_transactions.dart';
import 'components/transaction_statistics.dart';
import 'components/upcoming_bill.dart';

class TransactionManagement extends StatelessWidget {
  const TransactionManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      TotalBalance(),
                      const SizedBox(height: 10),
                      RecentTransactions(),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      UpcomingBill(),
                      const SizedBox(height: 10),
                      TransactionStatistics(),
                      const SizedBox(height: 10),
                      CategoriesRevenue(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
