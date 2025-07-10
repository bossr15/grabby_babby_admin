import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_state.dart';

import '../../../../logic/users_management/user_cubit.dart';
import 'components/users_tab_bar_actions.dart';

class UsersTabBar extends StatelessWidget {
  const UsersTabBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      final cubit = context.read<UserCubit>();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.zero,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                controller: tabController,
                padding: EdgeInsets.zero,
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onTap: (index) {
                  cubit.setSelectedIndex(index);
                },
                unselectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                labelColor: AppColors.black,
                unselectedLabelColor: Colors.black,
                dividerHeight: 0,
                indicatorWeight: 0.1,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                tabs: [
                  Tab(
                    iconMargin: EdgeInsets.zero,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        border: Border(
                          right: BorderSide(color: Colors.grey.shade300),
                        ),
                        color: state.selectedIndex == 0
                            ? AppColors.lightBlue.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Center(
                          child: Text(
                            'All Users',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: Border(
                          right: BorderSide(color: Colors.grey.shade300),
                        ),
                        color: state.selectedIndex == 1
                            ? AppColors.lightBlue.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Center(
                          child: Text(
                            'Suspended Users',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 50),
            Expanded(child: UsersTabBarActions()),
          ],
        ),
      );
    });
  }
}
