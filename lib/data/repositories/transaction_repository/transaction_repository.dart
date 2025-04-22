import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/models/transactions_model/transaction_comparision_model.dart';
import 'package:grabby_babby_admin/data/models/transactions_model/transaction_management_model.dart';
import 'package:grabby_babby_admin/initializer.dart';

class TransactionRepository {
  Future<Either<String, TransactionManagementModel>>
      getTransactionDetail() async {
    final response = await networkRepository.get(url: "/admin/transactions");
    if (!response.failed) {
      final data = response.data["data"];
      final parsedData = TransactionManagementModel.fromJson(data);
      return right(parsedData);
    }
    return left(response.message);
  }

  Future<Either<String, TransactionComparisionModel>> getTransactionComparision(
      {String type = "weekly"}) async {
    final response = await networkRepository.get(
        url: "/admin/transactions/comparision", extraQuery: {"type": type});
    if (!response.failed) {
      final data = response.data["data"];
      final parsedData = TransactionComparisionModel.fromJson(data);
      return right(parsedData);
    }
    return left(response.message);
  }
}
