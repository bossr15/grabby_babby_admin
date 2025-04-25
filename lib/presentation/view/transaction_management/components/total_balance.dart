import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_cubit.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';
import '../../../logic/transaction_management/transaction_state.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Balance",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${state.transactions.totalBalance}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Text(
              "All Accounts",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Container(
              constraints: BoxConstraints(maxHeight: context.height * 0.15),
              child: SingleChildScrollView(
                child: Column(
                  children: state.transactions.adminTransactions
                      .map((transaction) => Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildTransactionItem(
                                transaction.amount?.toStringAsFixed(2) ??
                                    "0.00"),
                          ))
                      .toList(),
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 5,
            //   ),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: AppColors.darkBlue),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Center(
            //     child: Text(
            //       'View All',
            //       style: TextStyle(
            //         color: AppColors.darkBlue,
            //         fontSize: 16,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  Widget _buildTransactionItem(String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Received",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        Row(
          children: [
            Text(
              amount,
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(AppImages.arrowUp),
          ],
        ),
      ],
    );
  }
}
