import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/analytics_repository/analytics_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/analytics/analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit() : super(AnalyticsState.empty()) {
    fetchAnalytics();
    fetchRevenue();
  }

  final analyticsRepository = AnalyticsRepository();

  void fetchAnalytics() {
    emit(state.copyWith(isLoading: true));
    final extraQuery = {
      if (state.startDate != null)
        'startDate': state.startDate!.toIso8601String(),
      if (state.endDate != null) 'endDate': state.endDate!.toIso8601String(),
    };
    analyticsRepository.getAnalytics(extraQuery: extraQuery).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, analytics: data));
            },
          ),
        );
  }

  void fetchRevenue() {
    emit(state.copyWith(isRevenueLoading: true));
    analyticsRepository
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
    fetchRevenue();
  }

  void setDate(DateTimeRange pickedRange) async {
    emit(state.copyWith(
      startDate: pickedRange.start,
      endDate: pickedRange.end,
    ));
    fetchAnalytics();
  }
}
