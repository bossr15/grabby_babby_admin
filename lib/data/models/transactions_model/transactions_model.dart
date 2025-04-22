import 'package:grabby_babby_admin/data/models/order_model/order_model.dart';

import '../user_model/user_model.dart';

class TransactionsModel {
  int? id;
  String? type;
  double? amount;
  int? orderId;
  String? note;
  int? userId;
  UserModel? user;
  OrderModel? order;
  DateTime? createdAt;
  DateTime? updatedAt;

  TransactionsModel({
    this.id,
    this.order,
    this.user,
    this.type,
    this.amount,
    this.orderId,
    this.note,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      id: json['id'],
      type: json['type'] != null && json['type'] == "DEPOSITE"
          ? "Deposit"
          : json["type"] != null
              ? "Withdraw"
              : null,
      order: json['order'] != null ? OrderModel.fromJson(json['order']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      amount: json['amount']?.toDouble(),
      orderId: json['orderId'],
      note: json['note'],
      userId: json['userId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
