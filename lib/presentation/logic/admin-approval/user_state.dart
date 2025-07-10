import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

import '../../../data/models/dashboard_model/dashboard_model.dart';
import '../../../data/models/order_model/order_model.dart';

class UserState {
  DashBoardHeaderStats userHeaderStats;
  Map<Status, UserViewModel> users;
  int selectedIndex;
  String search;
  String userType;
  DateTime? startDate;
  DateTime? endDate;

  UserState({
    required this.users,
    required this.userHeaderStats,
    this.selectedIndex = 0,
    this.endDate,
    this.search = "",
    this.userType = "All",
    this.startDate,
  });

  factory UserState.empty() => UserState(
        userHeaderStats: DashBoardHeaderStats(),
        users: {
          Status.all: UserViewModel(),
          Status.suspend: UserViewModel(),
        },
      );

  copyWith({
    DashBoardHeaderStats? userHeaderStats,
    Map<Status, UserViewModel>? users,
    int? selectedIndex,
    String? search,
    String? userType,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return UserState(
      userHeaderStats: userHeaderStats ?? this.userHeaderStats,
      users: users ?? this.users,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      search: search ?? this.search,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      userType: userType ?? this.userType,
    );
  }
}
