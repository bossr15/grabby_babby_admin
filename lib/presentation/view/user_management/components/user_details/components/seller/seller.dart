import 'package:flutter/material.dart';

import '../products_card.dart';
import '../profile_card.dart';
import '../top_selling_products.dart';
import '../sales_overtime_chart.dart';
import '../total_revenue_card.dart';

class Seller extends StatelessWidget {
  const Seller({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ProfileCard(title: 'Seller Profile'),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: PurchasedProductsCard(title: 'Listed Products'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: TopSellingProducts(),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Column(
                  children: const [
                    SalesOvertimeChart(),
                    SizedBox(height: 24),
                    TotalRevenueCard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
