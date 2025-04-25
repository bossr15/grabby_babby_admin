import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_images.dart';
import 'package:grabby_babby_admin/core/utils/date_helpers.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_state.dart';

class UpcomingBill extends StatelessWidget {
  const UpcomingBill({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
      final incomingOrdersProducts = state.transactions.incomingOrdersProducts;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Bill',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                constraints: BoxConstraints(
                  maxHeight: context.height * 0.4,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: incomingOrdersProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildBillItem(
                          product.name ?? "",
                          (product.userId ?? 0).toString(),
                          DateHelpers.formatDate(
                              DateHelpers.parseDate(product.createdAt ?? "")),
                          '\$${product.price}',
                          context,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBillItem(
    String productName,
    String storeName,
    String date,
    String commission,
    BuildContext context,
  ) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(AppImages.productImage1),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          commission,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
