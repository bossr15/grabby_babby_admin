import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/dashboard/dashboard_state.dart';

import '../../../data/repositories/dashboard_repository/dashboard_repository.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.empty()) {
    fetchDashboardStats();
    fetchDashboardRevenue();
  }

  final dashBoardRepository = DashBoardRepository();

  void fetchDashboardStats() {
    emit(state.copyWith(isLoading: true));
    final extraQuery = {
      'startDate': state.startDate.toIso8601String(),
      'endDate': state.endDate.toIso8601String(),
    };
    dashBoardRepository.getDashboardStats(extraQuery: extraQuery).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, dashboardStats: data));
            },
          ),
        );
  }

  void fetchDashboardRevenue() {
    emit(state.copyWith(isRevenueLoading: true));
    dashBoardRepository
        .getRevenueStats(filter: state.revenueFilter.toLowerCase())
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isRevenueLoading: false));
            },
            (data) {
              emit(state.copyWith(isRevenueLoading: false, revenueModel: data));
            },
          ),
        );
  }

  void setRevenueFilter(String filter) async {
    emit(state.copyWith(revenueFilter: filter));
    fetchDashboardRevenue();
  }

  void setDate(DateTimeRange pickedRange) async {
    emit(state.copyWith(
      startDate: pickedRange.start,
      endDate: pickedRange.end,
    ));
    fetchDashboardStats();
  }
}
