import 'package:flutter/material.dart';

import '../latest_orders.dart';
import '../products_card.dart';
import '../profile_card.dart';
import '../sales_overtime_chart.dart';
import '../top_selling_products.dart';
import '../total_revenue_card.dart';

class BusinessSeller extends StatelessWidget {
  const BusinessSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 29,
          children: [
            Expanded(child: ProfileCard(title: 'Seller Profile')),
            Expanded(child: PurchasedProductsCard(title: 'Listed Products')),
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
        LatestOrders(),
      ],
    );
  }
}
