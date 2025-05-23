import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/models/dashboard_model/dashboard_model.dart';
import 'package:grabby_babby_admin/data/models/revenue/revenue_model.dart';
import 'package:grabby_babby_admin/initializer.dart';

class DashBoardRepository {
  Future<Either<String, DashboardModel>> getDashboardStats(
      {Map<String, dynamic>? extraQuery}) async {
    final response = await networkRepository.get(
        url: "/admin/dashboard", extraQuery: extraQuery);
    if (!response.failed) {
      final data = response.data["data"];
      final parsedData = DashboardModel.fromJson(data);
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
