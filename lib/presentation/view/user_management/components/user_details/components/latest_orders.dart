import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/date_helpers.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/core/widgets/listing_table/listing_column.dart';
import 'package:grabby_babby_admin/core/widgets/listing_table/listing_table.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_detail/user_detail_cubit.dart';

import '../../../../../../core/styles/app_color.dart';
import '../../../../../../core/widgets/listing_table/listing_cell.dart';
import '../../../../../../core/widgets/listing_table/listing_row.dart';
import '../../../../../../data/models/order_model/order_model.dart';
import '../../../../../../data/models/products_model/product_model.dart';
import '../../../../../logic/users_management/user_detail/user_detail_state.dart';

class LatestOrders extends StatelessWidget {
  const LatestOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailCubit, UserDetailState>(
      builder: (context, state) {
        final orders = state.sellerDetail.orders;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            width: double.infinity,
            height: context.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Latest Orders",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        context.read<UserDetailCubit>().getSellerOrderCsv();
                      },
                      child: Text(
                        "Export",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
                Expanded(
                  child: ListingTable(
                    columns: [
                      ListingColumn(
                        title: Text('Order ID'),
                      ),
                      ListingColumn(
                        title: Text('Product'),
                      ),
                      ListingColumn(
                        title: Text('Order Date'),
                      ),
                      ListingColumn(
                        title: Text('Price'),
                      ),
                      ListingColumn(
                        title: Text('Payment'),
                      ),
                      ListingColumn(
                        title: Text('Status'),
                      ),
                      ListingColumn(
                        title: Text('Action'),
                      ),
                    ],
                    rows: orders.mapIndexed((index, item) {
                      final orderItem =
                          item.orderItems?.firstOrNull ?? OrderItem();
                      final orderProduct = orderItem.product ?? ProductModel();
                      final status = item.paymentStatus ?? "Pending";
                      return ListingRow(
                        cells: [
                          ListingCell(child: Text('#${item.id}')),
                          ListingCell(child: Text(orderProduct.name ?? "")),
                          ListingCell(
                              child: Text(DateHelpers.formatDate(
                                  item.createdAt!,
                                  format: "MMM d, hh:mm a"))),
                          ListingCell(child: Text('\$${item.totalAmount}')),
                          ListingCell(
                              child: Text(item.totalAmount?.toString() ?? "")),
                          ListingCell(
                              child: Text(
                            status,
                            style: TextStyle(
                                color: status == "Processing"
                                    ? AppColors.yellowText
                                    : AppColors.greenText),
                          )),
                          ListingCell(child: Text('•••')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
