import 'package:grabby_babby_admin/core/utils/utils.dart';

class RevenueModel {
  double totalRevenue;
  List<RevenueAxis> revenueAxis;

  RevenueModel({required this.totalRevenue, required this.revenueAxis});

  factory RevenueModel.fromJson(Map<String, dynamic> json) {
    return RevenueModel(
      totalRevenue: json['totalRevenue'],
      revenueAxis: parseList(json['revenue'], RevenueAxis.fromJson),
    );
  }
}

class RevenueAxis {
  String x;
  double y;

  RevenueAxis({required this.x, required this.y});

  factory RevenueAxis.fromJson(Map<String, dynamic> json) {
    return RevenueAxis(
      x: json['x'],
      y: json['y'],
    );
  }
}
