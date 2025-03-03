import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/core/widgets/listing_table/listing_column.dart';
import 'package:grabby_babby_admin/core/widgets/listing_table/listing_table.dart';

import '../../../../../../core/styles/app_color.dart';
import '../../../../../../core/widgets/listing_table/listing_cell.dart';
import '../../../../../../core/widgets/listing_table/listing_row.dart';

class LatestOrders extends StatelessWidget {
  const LatestOrders({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text(
              "Latest Orders",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                rows: List.generate(10, (index) {
                  final status =
                      ["Processing", "Completed"][Random().nextInt(2)];
                  final payment =
                      ["Transfer", "Credit Card"][Random().nextInt(2)];
                  return ListingRow(
                    cells: [
                      ListingCell(child: Text('#2456JL')),
                      ListingCell(child: Text('Game Name')),
                      ListingCell(child: Text('Jan 12, 12:23 pm')),
                      ListingCell(child: Text('\$134')),
                      ListingCell(child: Text(payment)),
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
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
