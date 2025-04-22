import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/data/models/products_model/product_model.dart';
import 'package:grabby_babby_admin/data/models/transactions_model/transaction_products_stats.dart';
import 'package:grabby_babby_admin/data/models/transactions_model/transactions_model.dart';

class TransactionManagementModel {
  double totalBalance;
  List<TransactionsModel> allTransactions;
  List<TransactionsModel> buyerTransactions;
  List<TransactionsModel> sellerTransactions;
  List<TransactionsModel> adminTransactions;
  List<ProductModel> incomingOrdersProducts;
  List<TransactionProductsStats> stats;

  TransactionManagementModel({
    required this.totalBalance,
    required this.allTransactions,
    required this.buyerTransactions,
    required this.sellerTransactions,
    required this.adminTransactions,
    required this.incomingOrdersProducts,
    required this.stats,
  });

  factory TransactionManagementModel.fromJson(Map<String, dynamic> json) {
    return TransactionManagementModel(
        totalBalance: json["totalBalance"],
        stats: parseList(json["stats"], TransactionProductsStats.fromJson),
        allTransactions:
            parseList(json["allTransactions"], TransactionsModel.fromJson),
        buyerTransactions:
            parseList(json["buyerTransactions"], TransactionsModel.fromJson),
        sellerTransactions:
            parseList(json["sellerTransactions"], TransactionsModel.fromJson),
        adminTransactions:
            parseList(json["adminTransactions"], TransactionsModel.fromJson),
        incomingOrdersProducts:
            parseList(json["incomingOrdersProducts"], ProductModel.fromJson));
  }
}
