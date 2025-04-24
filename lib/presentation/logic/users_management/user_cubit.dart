import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/debouncer.dart';
import 'package:grabby_babby_admin/data/models/paginate/paginate.dart';
import 'package:grabby_babby_admin/data/repositories/user_repository/user_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_state.dart';

import '../../../data/models/order_model/order_model.dart';

class UserCubit extends Cubit<UserState> {
  final userRepository = UserRepository();
  final debouncer = Debouncer();

  UserCubit() : super(UserState.empty()) {
    fetchUserDashboardStats();
    state.users.forEach((key, value) {
      fetchUsers(key);
      attachListener(status: key);
    });
  }

  void fetchUserDashboardStats() {
    userRepository.getUserDashboardStats().then(
          (response) => response.fold(
            (error) {},
            (data) {
              emit(state.copyWith(userHeaderStats: data));
            },
          ),
        );
  }

  void fetchData({bool refresh = false}) {
    state.users.forEach((key, value) => fetchUsers(key, refresh: refresh));
  }

  void attachListener({required Status status}) {
    state.users[status]!.scrollController.addListener(() {
      if (state.users[status]!.scrollController.position.pixels >
          state.users[status]!.scrollController.position.maxScrollExtent -
              200) {
        if (!state.users[status]!.isScrolling &&
            state.users[status]!.users.currentPage <
                state.users[status]!.users.totalPages) {
          goToNextPage(status: status);
        }
      }
    });
  }

  void goToNextPage({required Status status}) {
    state.users[status]!.users.currentPage++;
    state.users[status]!.isScrolling = true;
    emit(state);
    fetchUsers(status);
  }

  void fetchUsers(Status status, {bool refresh = false}) {
    state.users[status]!.isLoading = true;
    if (refresh) state.users[status]!.users = Paginate.empty();
    emit(state.copyWith(users: state.users));
    final extraQuery = {
      if (state.startDate != null)
        'startDate': state.startDate!.toIso8601String(),
      if (state.endDate != null) 'endDate': state.endDate!.toIso8601String(),
      if (state.search.isNotEmpty) 'search': state.search,
      "userType": state.userType.toUpperCase(),
    };
    userRepository
        .getAllUsers(
            previousData: state.users[status]!.users,
            extraQuery: extraQuery,
            status: status)
        .then(
          (response) => response.fold(
            (error) {
              state.users[status]!.isLoading = false;
              state.users[status]!.isScrolling = false;
              emit(state.copyWith(users: state.users));
            },
            (data) {
              state.users[status]!.isLoading = false;
              state.users[status]!.isScrolling = false;
              state.users[status]!.users = data;
              emit(state.copyWith(users: state.users));
            },
          ),
        );
  }

  void setDate(DateTimeRange pickedRange) async {
    emit(state.copyWith(
      startDate: pickedRange.start,
      endDate: pickedRange.end,
    ));
    fetchData(refresh: true);
  }

  void searchUsers(String query) {
    state.search = query;
    debouncer.call(() => fetchData(refresh: true));
  }

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void setUserType(String userType) {
    emit(state.copyWith(userType: userType));
    fetchData(refresh: true);
  }
}
