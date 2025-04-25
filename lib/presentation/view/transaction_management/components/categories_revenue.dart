import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_state.dart';

class CategoriesRevenue extends StatelessWidget {
  const CategoriesRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
      final categories = state.transactions.stats;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Product Categories & Revenue Statics',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Spacer(),
                Text(
                  '*Compare to last month',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
                spacing: 16,
                runSpacing: 16,
                children: categories.map((category) {
                  return _buildCategoryCard(
                    category.categoryName,
                    '\$${category.currentRevenue.toStringAsFixed(2)}',
                    Icons.games,
                    category.change,
                    isIncrease: category.change > 0,
                  );
                }).toList()),
          ],
        ),
      );
    });
  }

  Widget _buildCategoryCard(
      String name, String amount, IconData icon, int change,
      {bool isIncrease = true}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(icon, color: Colors.grey[600]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 14,
                      color: isIncrease ? Colors.green : Colors.red,
                    ),
                    Text(
                      '$change%',
                      style: TextStyle(
                        fontSize: 12,
                        color: isIncrease ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
