import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/styles/app_images.dart';

import '../../../../../../core/widgets/listing_table/listing_cell.dart';
import '../../../../../../core/widgets/listing_table/listing_column.dart';
import '../../../../../../core/widgets/listing_table/listing_row.dart';
import '../../../../../../core/widgets/listing_table/listing_table.dart';

class UsersTable extends StatelessWidget {
  const UsersTable(
      {super.key,
      required this.status,
      required this.statusColor,
      required this.statusTextColor});
  final String status;
  final Color statusColor;
  final Color statusTextColor;

  @override
  Widget build(BuildContext context) {
    return ListingTable(
      rowHeight: 50,
      columns: [
        ListingColumn(
          title: Text('Name'),
        ),
        ListingColumn(
          title: Text('User ID'),
        ),
        ListingColumn(
          title: Text('Email'),
        ),
        ListingColumn(
          title: Text('Phone'),
        ),
        ListingColumn(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Account Type'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        ListingColumn(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Status'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        ListingColumn(
          title: Text('Actions'),
        ),
      ],
      rows: List.generate(25, (index) {
        return ListingRow(cells: [
          ListingCell(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(AppImages.dummyUser),
              ),
              const SizedBox(width: 8),
              Text('Alex Johnson'),
            ],
          )),
          ListingCell(child: Text('B125')),
          ListingCell(
              child: Text(
            'alex.joe@gmail.com',
            style: TextStyle(
              color: AppColors.darkBlue,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.darkBlue,
            ),
          )),
          ListingCell(child: Text('+1234567890')),
          ListingCell(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                  child: Text([
                "Buyer",
                "Business Seller",
                "Seller"
              ][Random().nextInt(3)])),
            ),
          )),
          ListingCell(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                  child: Text(
                status,
                style: TextStyle(
                  color: statusTextColor,
                ),
              )),
            ),
          )),
          ListingCell(child: Text('Actions')),
        ]);
      }),
      isLoading: false,
    );
  }
}
