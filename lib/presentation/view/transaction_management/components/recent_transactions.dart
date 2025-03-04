import 'package:flutter/material.dart';

import '../../../../core/styles/app_color.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Transaction',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(color: AppColors.grey),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFilterChip('All', isSelected: true),
              const SizedBox(width: 8),
              _buildFilterChip('Buyers'),
              const SizedBox(width: 8),
              _buildFilterChip('Sellers'),
            ],
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
            'Game name',
            '\$16000.00',
            '17 May 2023',
            Icons.games,
            isBuyer: true,
          ),
          _buildTransactionItem(
            'Game name',
            '\$16000.00',
            '17 May 2023',
            Icons.games,
            isBuyer: true,
          ),
          _buildTransactionItem(
            'Game name',
            '\$16000.00',
            '17 May 2023',
            Icons.games,
            isBuyer: true,
          ),
          _buildTransactionItem(
            'Game name',
            '\$16000.00',
            '17 May 2023',
            Icons.games,
            isBuyer: true,
          ),
          _buildTransactionItem(
            'Money Withdraw',
            '\$20000.00',
            '17 May 2023',
            Icons.account_balance_wallet,
            isBuyer: false,
          ),
          _buildTransactionItem(
            'Game name',
            '\$10000.00',
            '17 May 2023',
            Icons.games,
            isBuyer: true,
          ),
          _buildTransactionItem(
            'Game name',
            '\$1200.00',
            '17 May 2023',
            Icons.games,
            isBuyer: true,
          ),
          _buildTransactionItem(
            'Money Withdraw',
            '\$12000.00',
            '17 May 2023',
            Icons.account_balance_wallet,
            isBuyer: false,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.greenText : AppColors.grey,
              fontSize: 16,
            ),
          ),
          if (isSelected)
            Container(
              width: 30,
              height: 2,
              color: AppColors.greenText,
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String amount,
    String date,
    IconData icon, {
    bool isBuyer = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isBuyer ? Colors.green[50] : Colors.orange[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isBuyer ? 'Buyer' : 'Seller',
                        style: TextStyle(
                          color:
                              isBuyer ? Colors.green[700] : Colors.orange[700],
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
