import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/data/models/order_model/order_model.dart';
import 'products_table/products_table.dart';

class ProductsTabView extends StatelessWidget {
  const ProductsTabView({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        ProductsTable(status: Status.pending),
        ProductsTable(status: Status.approved),
      ],
    );
  }
}
