import 'package:grabby_babby_admin/core/utils/utils.dart';

class DashboardModel {
  final DashBoardHeaderStats headerStats;
  final List<DashBoardUsersStats> sellerStats;
  final List<DashBoardUsersStats> buyerStats;

  DashboardModel({
    required this.headerStats,
    required this.sellerStats,
    required this.buyerStats,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        buyerStats: parseList(json["buyerAccountCreationAnalytics"],
            DashBoardUsersStats.fromJson),
        sellerStats: parseList(json["sellerAccountCreationAnalytics"],
            DashBoardUsersStats.fromJson),
        headerStats: DashBoardHeaderStats.fromJson(json["totalCounts"]),
      );
}

class DashBoardUsersStats {
  final String date;
  final int usersCreated;

  DashBoardUsersStats({
    required this.date,
    required this.usersCreated,
  });

  factory DashBoardUsersStats.fromJson(Map<String, dynamic> json) =>
      DashBoardUsersStats(
        date: json["date"],
        usersCreated: json["usersCreated"],
      );
}

class DashBoardHeaderStats {
  final int sellerCounts;
  final int buyerCounts;
  final int suspendedCounts;
  final double totalEarnings;

  DashBoardHeaderStats({
    this.buyerCounts = 0,
    this.sellerCounts = 0,
    this.suspendedCounts = 0,
    this.totalEarnings = 0,
  });

  factory DashBoardHeaderStats.fromJson(Map<String, dynamic> json) =>
      DashBoardHeaderStats(
        sellerCounts: json["totalSellerCounts"],
        buyerCounts: json["totalBuyersCounts"],
        suspendedCounts: json["suspendUsers"],
        totalEarnings: double.tryParse(json["totalEarnings"].toString()) ?? 0.0,
      );
}
