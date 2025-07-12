import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/core/widgets/dialogs/product_detail_dialog.dart';
import 'package:grabby_babby_admin/data/models/order_model/order_model.dart';
import 'package:grabby_babby_admin/presentation/logic/product_management/product_cubit.dart';
import '../../../../../../core/widgets/listing_table/listing_cell.dart';
import '../../../../../../core/widgets/listing_table/listing_column.dart';
import '../../../../../../core/widgets/listing_table/listing_row.dart';
import '../../../../../../core/widgets/listing_table/listing_table.dart';
import '../../../../../../data/models/products_model/product_model.dart';
import '../../../../../logic/product_management/product_state.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key, required this.status});
  final Status status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      final cubit = context.read<ProductCubit>();
      final currentUser = state.products[status] ?? ProductViewModel();
      final isScrolling = currentUser.isScrolling;
      final isLoading = currentUser.isLoading && !isScrolling;
      final products = currentUser.products.getCachedData();

      return ListingTable(
        scrollController: currentUser.scrollController,
        rowHeight: 50,
        columns: [
          ListingColumn(
            title: Text('Product ID'),
          ),
          ListingColumn(
            title: Text('Name'),
          ),
          ListingColumn(
            title: Text('Price'),
          ),
          ListingColumn(
            title: Text('State'),
          ),
          ListingColumn(
            title: Text('Product Condition'),
          ),
          ListingColumn(
            title: Text('Status'),
          ),
          ListingColumn(
            title: Text('Actions'),
          ),
        ],
        rows: products.mapIndexed((index, product) {
          return ListingRow(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ProductApprovalDialog(
                    product: product,
                    onApprove: () {
                      cubit.updatProductstatus(
                          id: product.id.toString(), status: Status.approved);
                    },
                  ),
                );
              },
              cells: [
                ListingCell(child: Text(product.id?.toString() ?? "")),
                ListingCell(
                  child: Text(product.name ?? ""),
                  alignment: Alignment.centerLeft,
                ),
                ListingCell(
                    child: Text(
                  "\$${product.price?.toString() ?? ""}",
                  style: TextStyle(
                    color: AppColors.greenText,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.greenText,
                  ),
                )),
                ListingCell(child: Text(product.state ?? "")),
                ListingCell(child: Text(product.productCondition ?? "")),
                ListingCell(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: getStatusChipColor(product.status!),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                      fromStatus(product.status!),
                      style: TextStyle(
                        color: getOrderChipTextColor(product.status!),
                      ),
                    )),
                  ),
                )),
                ListingCell(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ProductApprovalDialog(
                            product: product,
                            onApprove: () {
                              cubit.updatProductstatus(
                                  id: product.id.toString(),
                                  status: Status.approved);
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: appGradient,
                          ),
                          child: Center(
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ]);
        }).toList(),
        isLoading: isLoading,
      );
    });
  }
}
