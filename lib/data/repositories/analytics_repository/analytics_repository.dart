import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/models/analytics_model/analytics_model.dart';
import 'package:grabby_babby_admin/initializer.dart';

import '../../models/revenue/revenue_model.dart';

class AnalyticsRepository {
  Future<Either<String, AnalyticsModel>> getAnalytics(
      {Map<String, dynamic>? extraQuery}) async {
    final response = await networkRepository.get(
        url: "/admin/analytics-and-reporting", extraQuery: extraQuery);
    if (!response.failed) {
      final data = response.data["data"];
      final parsedData = AnalyticsModel.fromJson(data);
      return right(parsedData);
    }
    return left(response.message);
  }

  Future<Either<String, RevenueModel>> getRevenueStats(
      {String filter = "month"}) async {
    final response = await networkRepository.get(
      url: "/admin/revenue",
      extraQuery: {"filter": filter},
    );
    if (!response.failed) {
      final data = response.data["data"];
      final parsedData = RevenueModel.fromJson(data);
      return right(parsedData);
    }
    return left(response.message);
  }
}
