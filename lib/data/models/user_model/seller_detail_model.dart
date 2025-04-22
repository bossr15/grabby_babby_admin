import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/data/models/products_model/product_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

import '../order_model/order_model.dart';

class SellerDetailModel {
  double revenuePercentageDifference;
  int totalRevenueCurrentMonth;
  UserModel seller;
  List<MonthlySales> monthlySales;
  List<ProductModel> products;
  List<ProductModel> topSellingProducts;
  List<OrderModel> orders;

  SellerDetailModel({
    this.revenuePercentageDifference = 0,
    this.totalRevenueCurrentMonth = 0,
    required this.seller,
    required this.monthlySales,
    required this.products,
    required this.topSellingProducts,
    required this.orders,
  });

  factory SellerDetailModel.fromJson(Map<String, dynamic> json) {
    return SellerDetailModel(
      revenuePercentageDifference:
          double.tryParse(json["revenuePercentDifference"].toString()) ?? 0,
      totalRevenueCurrentMonth: json["totalRevenueCurrentMonth"],
      seller: UserModel.fromJson(json["seller"] ?? {}),
      monthlySales: parseList(json["monthlySalesGraph"], MonthlySales.fromJson),
      products: parseList(json["products"], ProductModel.fromJson),
      topSellingProducts:
          parseList(json["topSellingProducts"], ProductModel.fromJson),
      orders: parseList(json["ordersList"], OrderModel.fromJson),
    );
  }
}

class MonthlySales {
  String month;
  int sales;
  int revenue;

  MonthlySales({
    required this.month,
    required this.sales,
    required this.revenue,
  });

  factory MonthlySales.fromJson(Map<String, dynamic> json) {
    return MonthlySales(
      month: json["month"],
      sales: json["sales"],
      revenue: json["revenue"],
    );
  }
}
