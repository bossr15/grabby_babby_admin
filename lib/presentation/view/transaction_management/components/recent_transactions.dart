import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/data/models/products_model/product_model.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_state.dart';

import '../../../../core/styles/app_color.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
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
            const Text(
              'Recent Transaction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TabBar(
                unselectedLabelStyle: TextStyle(
                    color: Color(0xff525256),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                labelStyle: TextStyle(
                    color: AppColors.greenText,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                indicatorColor: AppColors.greenText,
                controller: _tabController,
                tabs: [
                  Text(
                    "All",
                  ),
                  Text(
                    "Buyers",
                  ),
                  Text(
                    "Sellers",
                  ),
                ]),
            SizedBox(
              height: context.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: state.transactions.allTransactions.length,
                      itemBuilder: (context, index) {
                        final item = state.transactions.allTransactions[index];
                        final product =
                            item.order?.orderItems?.firstOrNull?.product ??
                                ProductModel();
                        final isBuyer = item.user?.role == "BUYER";
                        return _buildTransactionItem(
                          product.name ?? "",
                          item.amount.toString(),
                          item.createdAt.toString(),
                          [
                            Icons.account_balance_wallet,
                            Icons.account_balance_wallet
                          ][Random().nextInt(2)],
                          isBuyer: isBuyer,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: state.transactions.buyerTransactions.length,
                      itemBuilder: (context, index) {
                        final item =
                            state.transactions.buyerTransactions[index];
                        final product =
                            item.order?.orderItems?.firstOrNull?.product ??
                                ProductModel();
                        final isBuyer = item.user?.role == "BUYER";
                        return _buildTransactionItem(
                          product.name ?? "",
                          item.amount.toString(),
                          item.createdAt.toString(),
                          [
                            Icons.account_balance_wallet,
                            Icons.account_balance_wallet
                          ][Random().nextInt(2)],
                          isBuyer: isBuyer,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: state.transactions.sellerTransactions.length,
                      itemBuilder: (context, index) {
                        final item =
                            state.transactions.sellerTransactions[index];
                        final product =
                            item.order?.orderItems?.firstOrNull?.product ??
                                ProductModel();
                        final isBuyer = item.user?.role == "BUYER";
                        return _buildTransactionItem(
                          product.name ?? "",
                          item.amount.toString(),
                          item.createdAt.toString(),
                          [
                            Icons.account_balance_wallet,
                            Icons.account_balance_wallet
                          ][Random().nextInt(2)],
                          isBuyer: isBuyer,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
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
