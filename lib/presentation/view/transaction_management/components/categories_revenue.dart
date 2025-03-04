import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';

class CategoriesRevenue extends StatelessWidget {
  const CategoriesRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      width: context.width * 0.6,
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
            children: [
              _buildCategoryCard(
                'Category Name',
                '\$2500.00',
                Icons.games,
                0.15,
                isIncrease: true,
              ),
              _buildCategoryCard(
                'Category Name',
                '\$350.00',
                Icons.download,
                0.35,
                isIncrease: false,
              ),
              _buildCategoryCard(
                'Category Name',
                '\$50.00',
                Icons.person,
                0.12,
                isIncrease: true,
              ),
              _buildCategoryCard(
                'Category Name',
                '\$80.00',
                Icons.diamond_outlined,
                0.15,
                isIncrease: false,
              ),
              _buildCategoryCard(
                'Category Name',
                '\$420.00',
                Icons.account_balance_wallet,
                0.25,
                isIncrease: true,
              ),
              _buildCategoryCard(
                'Category Name',
                '\$650.00',
                Icons.shopping_cart,
                0.23,
                isIncrease: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      String name, String amount, IconData icon, double percentage,
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
                      '${(percentage * 100).toStringAsFixed(1)}%',
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
