import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/data/models/order_model/order_model.dart';
import 'users_table/users_table.dart';

class UsersTabView extends StatelessWidget {
  const UsersTabView({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        UsersTable(status: Status.all),
        UsersTable(status: Status.suspend),
      ],
    );
  }
}
