import 'package:grabby_babby_admin/core/utils/utils.dart';

class AnalyticsModel {
  List<AnalyticsUser> sellers;
  List<AnalyticsUser> buyers;
  AnalyticsCounts counts;

  AnalyticsModel({
    required this.sellers,
    required this.buyers,
    required this.counts,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      sellers: parseList(json['sellerList'], AnalyticsUser.fromJson),
      buyers: parseList(json['buyerList'], AnalyticsUser.fromJson),
      counts: AnalyticsCounts.fromJson(json['totalCounts']),
    );
  }
}

class AnalyticsUser {
  String fullName;
  int orderCount;

  AnalyticsUser({
    required this.fullName,
    required this.orderCount,
  });

  factory AnalyticsUser.fromJson(Map<String, dynamic> json) {
    return AnalyticsUser(
      fullName: json['fullName'] as String,
      orderCount: json['orderCount'] as int,
    );
  }
}

class AnalyticsCounts {
  int productPurchaseCount;
  int totalUsersCount;
  int activeUserCount;
  int productsCount;
  int totalOrderItems;
  double totalEarnings;

  AnalyticsCounts({
    this.totalEarnings = 0,
    this.activeUserCount = 0,
    this.productPurchaseCount = 0,
    this.productsCount = 0,
    this.totalOrderItems = 0,
    this.totalUsersCount = 0,
  });

  factory AnalyticsCounts.fromJson(Map<String, dynamic> json) {
    return AnalyticsCounts(
      productPurchaseCount: json['productPuchasedCounts'],
      totalUsersCount: json['totalUsersCount'],
      activeUserCount: json['activeUsersCount'],
      productsCount: json['productCountsCount'],
      totalOrderItems: json['totalOrderItemsCount'],
      totalEarnings: double.tryParse(json["totalEarnings"].toString()) ?? 0,
    );
  }
}
