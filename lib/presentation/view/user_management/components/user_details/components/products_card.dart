import 'package:flutter/material.dart';

import '../../../../../../core/styles/app_images.dart';

class PurchasedProductsCard extends StatelessWidget {
  const PurchasedProductsCard({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildCategorySection('Category A', [
            _ProductItem(
              image: AppImages.productImage1,
              name: 'Fortnite Game',
              price: '\$70',
              state: 'NSW',
              date: '12/01/2025',
            ),
            _ProductItem(
              image: AppImages.productImage2,
              name: 'Fortnite Game',
              price: '\$70',
              state: 'NSW',
              date: '12/01/2025',
            ),
          ]),
          const SizedBox(height: 24),
          _buildCategorySection('Category B', [
            _ProductItem(
              image: AppImages.productImage3,
              name: 'Fortnite Game',
              price: '\$70',
              state: 'NSW',
              date: '12/01/2025',
            ),
          ]),
          const SizedBox(height: 24),
          _buildCategorySection('Category C', [
            _ProductItem(
              image: AppImages.productImage4,
              name: 'Fortnite Game',
              price: '\$70',
              state: 'NSW',
              date: '12/01/2025',
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String state;
  final String date;

  const _ProductItem({
    required this.image,
    required this.name,
    required this.price,
    required this.state,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Price: $price',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'State: $state',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
