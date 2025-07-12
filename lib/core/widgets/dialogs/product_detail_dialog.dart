import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';

import '../../../data/models/order_model/order_model.dart';
import '../../../data/models/products_model/product_model.dart';

class ProductApprovalDialog extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onApprove;

  const ProductApprovalDialog({
    super.key,
    required this.product,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: context.width * 0.5,
        height: context.height * 0.6,
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? 'Unnamed Product',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      _buildStatusChip(product.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Product ID: ${product.id?.toString() ?? "N/A"}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Details Grid
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Images Section
                            if (product.images != null &&
                                product.images!.isNotEmpty) ...[
                              _buildSectionTitle('Product Images'),
                              const SizedBox(height: 16),
                              _buildImageGallery(product.images!),
                              const SizedBox(height: 24),
                            ],

                            _buildSectionTitle('Product Information'),
                            const SizedBox(height: 16),
                            _buildDetailGrid([
                              _DetailItem(
                                  'Price',
                                  product.price != null
                                      ? "\$${product.price!.toStringAsFixed(2)}"
                                      : "N/A"),
                              _DetailItem(
                                  'GST',
                                  product.gst != null
                                      ? "${product.gst!.toStringAsFixed(1)}%"
                                      : "N/A"),
                              _DetailItem('Condition',
                                  product.productCondition ?? "N/A"),
                              _DetailItem(
                                  'Postage',
                                  product.postage != null
                                      ? "\$${product.postage!.toStringAsFixed(2)}"
                                      : "N/A"),
                            ]),

                            if (product.overview != null &&
                                product.overview!.isNotEmpty) ...[
                              const SizedBox(height: 24),
                              _buildSectionTitle('Product Overview'),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.bgColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.2)),
                                ),
                                child: Text(
                                  product.overview!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],

                            if (product.createdAt != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                'Created: ${product.createdAt}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => AppNavigation.pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (product.status == Status.pending) ...[
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        onApprove.call();
                        AppNavigation.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenText,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Approve Product",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(Status? status) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case Status.pending:
        backgroundColor = AppColors.yellow;
        textColor = AppColors.yellowText;
        statusText = 'Pending';
        break;
      case Status.approved:
        backgroundColor = AppColors.green;
        textColor = AppColors.greenText;
        statusText = 'Approved';
        break;
      case Status.rejected:
        backgroundColor = AppColors.red;
        textColor = AppColors.redText;
        statusText = 'Rejected';
        break;
      default:
        backgroundColor = AppColors.bgColor;
        textColor = AppColors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
    );
  }

  Widget _buildDetailGrid(List<_DetailItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildDetailCard(item.label, item.value);
      },
    );
  }

  Widget _buildImageGallery(List<String> images) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              width: 100,
              margin: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: AppColors.grey,
                            size: 32,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Error',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.darkBlue,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DetailItem {
  final String label;
  final String value;

  _DetailItem(this.label, this.value);
}
