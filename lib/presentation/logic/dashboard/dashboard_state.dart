import 'package:grabby_babby_admin/data/models/dashboard_model/dashboard_model.dart';
import 'package:grabby_babby_admin/data/models/revenue/revenue_model.dart';

class DashboardState {
  final DashboardModel dashboardStats;
  final RevenueModel revenueModel;
  String revenueFilter;
  bool isLoading;
  bool isRevenueLoading;
  DateTime? startDate;
  DateTime? endDate;

  DashboardState({
    required this.dashboardStats,
    required this.revenueModel,
    this.revenueFilter = 'Month',
    this.endDate,
    this.startDate,
    this.isLoading = false,
    this.isRevenueLoading = false,
  });

  factory DashboardState.empty() => DashboardState(
        revenueModel: RevenueModel(
          totalRevenue: 0,
          revenueAxis: [],
        ),
        dashboardStats: DashboardModel(
          headerStats: DashBoardHeaderStats(),
          buyerStats: [],
          sellerStats: [],
        ),
      );

  copyWith({
    DashboardModel? dashboardStats,
    RevenueModel? revenueModel,
    String? revenueFilter,
    bool? isLoading,
    bool? isRevenueLoading,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      DashboardState(
        dashboardStats: dashboardStats ?? this.dashboardStats,
        revenueModel: revenueModel ?? this.revenueModel,
        revenueFilter: revenueFilter ?? this.revenueFilter,
        isLoading: isLoading ?? this.isLoading,
        isRevenueLoading: isRevenueLoading ?? this.isRevenueLoading,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
}
