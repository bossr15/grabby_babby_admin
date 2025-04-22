import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/styles/app_images.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/data/models/order_model/order_model.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/navigation/route_name.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_state.dart';

import '../../../../../../core/widgets/dialogs/user_details_dialog.dart';
import '../../../../../../core/widgets/listing_table/listing_cell.dart';
import '../../../../../../core/widgets/listing_table/listing_column.dart';
import '../../../../../../core/widgets/listing_table/listing_row.dart';
import '../../../../../../core/widgets/listing_table/listing_table.dart';
import '../../../../../../data/models/user_model/user_model.dart';
import '../../../../../../initializer.dart';
import '../../../../../logic/users_management/user_cubit.dart';

class UsersTable extends StatelessWidget {
  const UsersTable(
      {super.key,
      required this.status,
      required this.statusColor,
      required this.statusTextColor});
  final Status status;
  final Color statusColor;
  final Color statusTextColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      final currentUser = state.users[status] ?? UserViewModel();
      final isScrolling = currentUser.isScrolling;
      final isLoading = currentUser.isLoading && !isScrolling;
      final users = currentUser.users.getCachedData();

      return ListingTable(
        scrollController: currentUser.scrollController,
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
        rows: users.mapIndexed((index, user) {
          return ListingRow(
              onTap: () {
                if (status == Status.all) {
                  localStorage.setString('accountType', user.role ?? "BUYER");
                  AppNavigation.pushNamed(
                    RouteName.userDetails,
                    extra: user.role,
                    pathParameters: {"id": user.id.toString()},
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => UserDetailsDialog(status: status),
                  );
                }
              },
              cells: [
                ListingCell(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(AppImages.dummyUser),
                      ),
                      const SizedBox(width: 8),
                      Text(user.fullName ?? ""),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                ),
                ListingCell(child: Text(user.id?.toString() ?? "")),
                ListingCell(
                    child: Text(
                  user.email ?? "",
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.darkBlue,
                  ),
                )),
                ListingCell(child: Text(user.phoneNumber ?? "")),
                ListingCell(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text(user.role ?? "BUYER")),
                  ),
                )),
                ListingCell(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                      fromStatus(status),
                      style: TextStyle(
                        color: statusTextColor,
                      ),
                    )),
                  ),
                )),
                ListingCell(
                    child: InkWell(
                  onTap: () {
                    if (status == Status.all) {
                      localStorage.setString(
                          'accountType', user.role ?? "BUYER");
                      AppNavigation.pushNamed(
                        RouteName.userDetails,
                        extra: user.role,
                        pathParameters: {"id": user.id.toString()},
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => UserDetailsDialog(status: status),
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Container(
                      padding: EdgeInsets.all(2),
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
