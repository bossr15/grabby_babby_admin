import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/jumping_dots.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_detail/user_detail_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_detail/user_detail_state.dart';
import 'package:grabby_babby_admin/presentation/view/user_management/components/user_details/components/buyer/buyer_view.dart';

import '../../../../../core/widgets/app_back_button.dart';
import 'components/business_seller/business_seller.dart';
import 'components/seller/seller.dart';

class UserDetails extends StatelessWidget {
  const UserDetails(
      {super.key, required this.userId, required this.accountType});
  final String userId;
  final String accountType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailCubit>(
      create: (context) =>
          UserDetailCubit(userId: userId, accountType: accountType),
      child: BlocBuilder<UserDetailCubit, UserDetailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    AppBackButton(),
                    const SizedBox(width: 10),
                    Text(
                      accountType == "BUYER"
                          ? "Buyer Account"
                          : accountType == "BUSINESSSELLER"
                              ? "Business Seller Profile"
                              : "Seller Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3d3d3d),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                state.isLoading
                    ? Row(
                        children: [
                          Spacer(),
                          JumpingDots(numberOfDots: 3),
                          Spacer(),
                        ],
                      )
                    : accountType == "BUYER"
                        ? const BuyerView()
                        : accountType == "BUSINESSSELLER"
                            ? const BusinessSeller()
                            : const Seller(),
              ],
            ),
          );
        },
      ),
    );
  }
}
