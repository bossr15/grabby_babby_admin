import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_cubit.dart';

import 'components/user_stats.dart';
import 'components/users_tab_bar/users_tab_bar.dart';
import 'components/users_tab_view/users_tab_view.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
        create: (context) => UserCubit(),
        child: Column(
          children: [
            UserStats(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Management",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      UsersTabBar(tabController: tabController),
                      Expanded(
                          child: UsersTabView(tabController: tabController)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
