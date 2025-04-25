import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import 'package:grabby_babby_admin/presentation/view/transaction_management/components/total_balance.dart';

import '../../../core/styles/app_color.dart';
import '../../logic/transaction_management/transaction_cubit.dart';
import '../../logic/transaction_management/transaction_state.dart';
import 'components/categories_revenue.dart';
import 'components/recent_transactions.dart';
import 'components/transaction_statistics.dart';
import 'components/upcoming_bill.dart';

class TransactionManagement extends StatelessWidget {
  const TransactionManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCubit>(
      create: (context) => TransactionCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(16),
          child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
            return state.isLoading
                ? AppIndicator(color: AppColors.darkBlue)
                : SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TotalBalance(),
                              const SizedBox(height: 10),
                              RecentTransactions(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              UpcomingBill(),
                              const SizedBox(height: 10),
                              TransactionStatistics(),
                              const SizedBox(height: 10),
                              CategoriesRevenue(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
