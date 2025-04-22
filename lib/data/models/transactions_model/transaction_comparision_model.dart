import 'package:grabby_babby_admin/core/utils/utils.dart';

class TransactionComparisionModel {
  List<TransactionCompariosnAxis> currentPeriod;
  List<TransactionCompariosnAxis> previousPeriod;

  TransactionComparisionModel({
    required this.currentPeriod,
    required this.previousPeriod,
  });

  factory TransactionComparisionModel.fromJson(Map<String, dynamic> json) {
    return TransactionComparisionModel(
      currentPeriod:
          parseList(json["currentPeriod"], TransactionCompariosnAxis.fromJson),
      previousPeriod:
          parseList(json["previousPeriod"], TransactionCompariosnAxis.fromJson),
    );
  }
}

class TransactionCompariosnAxis {
  String label;
  double value;

  TransactionCompariosnAxis({
    required this.label,
    required this.value,
  });

  factory TransactionCompariosnAxis.fromJson(Map<String, dynamic> json) {
    return TransactionCompariosnAxis(
      label: json["label"],
      value: json["value"],
    );
  }
}
