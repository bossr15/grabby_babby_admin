import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/view/user_management/components/user_details/components/buyer/buyer_view.dart';

import '../../../../../core/widgets/app_back_button.dart';
import 'components/business_seller/business_seller.dart';
import 'components/seller/seller.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.accountType});
  final String accountType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              AppBackButton(),
              const SizedBox(width: 10),
              Text(
                accountType == "Buyer"
                    ? "Buyer Account"
                    : accountType == "Business Seller"
                        ? "Business Seller Profile"
                        : "Seller Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          accountType == "Buyer"
              ? const BuyerView()
              : accountType == "Business Seller"
                  ? const BusinessSeller()
                  : const Seller(),
        ],
      ),
    );
  }
}
