import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';

import 'components/users_tab_bar_actions.dart';

class UsersTabBar extends StatefulWidget {
  const UsersTabBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<UsersTabBar> createState() => _UsersTabBarState();
}

class _UsersTabBarState extends State<UsersTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
              controller: widget.tabController,
              padding: EdgeInsets.zero,
              isScrollable: true,
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
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
                      color: selectedIndex == 0
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
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300),
                      ),
                      color: selectedIndex == 1
                          ? AppColors.lightBlue.withOpacity(0.2)
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Center(
                        child: Text(
                          'Requests for Approval (244)',
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
                      color: selectedIndex == 2
                          ? AppColors.lightBlue.withOpacity(0.2)
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Center(
                        child: Text(
                          'Suspended Users (100)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: UsersTabBarActions()),
        ],
      ),
    );
  }
}
