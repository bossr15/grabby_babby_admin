import 'package:grabby_babby_admin/data/models/analytics_model/analytics_model.dart';
import 'package:grabby_babby_admin/data/models/revenue/revenue_model.dart';

class AnalyticsState {
  final AnalyticsModel analytics;
  final RevenueModel revenueModel;
  String revenueFilter;
  bool isLoading;
  bool isRevenueLoading;
  DateTime? startDate;
  DateTime? endDate;

  AnalyticsState({
    required this.analytics,
    required this.revenueModel,
    this.revenueFilter = 'Month',
    this.isLoading = false,
    this.isRevenueLoading = false,
    this.endDate,
    this.startDate,
  });

  factory AnalyticsState.empty() => AnalyticsState(
        revenueModel: RevenueModel(
          totalRevenue: 0,
          revenueAxis: [],
        ),
        analytics: AnalyticsModel(
          sellers: [],
          buyers: [],
          counts: AnalyticsCounts(),
        ),
      );

  copyWith(
          {AnalyticsModel? analytics,
          bool? isRevenueLoading,
          bool? isLoading,
          String? revenueFilter,
          RevenueModel? revenueModel,
          DateTime? startDate,
          DateTime? endDate}) =>
      AnalyticsState(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        revenueFilter: revenueFilter ?? this.revenueFilter,
        revenueModel: revenueModel ?? this.revenueModel,
        analytics: analytics ?? this.analytics,
        isLoading: isLoading ?? this.isLoading,
        isRevenueLoading: isRevenueLoading ?? this.isRevenueLoading,
      );
}
