import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/models/dashboard_model/dashboard_model.dart';
import 'package:grabby_babby_admin/initializer.dart';

class DashBoardRepository {
  Future<Either<String, DashboardModel>> getDashboardStats() async {
    final response = await networkRepository.get(url: "/admin/dashboard");
    if (!response.failed) {
      final data = response.data["data"];
      final parsedData = DashboardModel.fromJson(data);
      return right(parsedData);
    }
    return left(response.message);
  }
}
