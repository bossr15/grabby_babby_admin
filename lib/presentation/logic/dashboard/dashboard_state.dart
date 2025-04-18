import 'package:grabby_babby_admin/data/models/dashboard_model/dashboard_model.dart';

class DashboardState {
  final DashboardModel dashboardStats;
  bool isLoading;

  DashboardState({
    required this.dashboardStats,
    this.isLoading = false,
  });

  factory DashboardState.empty() => DashboardState(
          dashboardStats: DashboardModel(
        headerStats: DashBoardHeaderStats(),
        buyerStats: [],
        sellerStats: [],
      ));

  copyWith({DashboardModel? dashboardStats, bool? isLoading}) => DashboardState(
        dashboardStats: dashboardStats ?? this.dashboardStats,
        isLoading: isLoading ?? this.isLoading,
      );
}
