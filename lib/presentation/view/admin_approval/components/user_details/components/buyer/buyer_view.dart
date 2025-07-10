import 'package:flutter/material.dart';
import '../profile_card.dart';
import '../products_card.dart';

class BuyerView extends StatelessWidget {
  const BuyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ProfileCard(title: 'Buyer Profile'),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 3,
          child: PurchasedProductsCard(title: 'Purchased Products'),
        ),
      ],
    );
  }
}
