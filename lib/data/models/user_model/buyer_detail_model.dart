import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/data/models/products_model/product_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class BuyerDetailModel {
  UserModel buyer;
  List<ProductModel> products;

  BuyerDetailModel({required this.buyer, required this.products});

  factory BuyerDetailModel.fromJson(Map<String, dynamic> json) {
    return BuyerDetailModel(
      buyer: UserModel.fromJson(json["buyer"]),
      products: parseList(json["products"], ProductModel.fromJson),
    );
  }
}
