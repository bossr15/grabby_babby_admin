import 'package:flutter/material.dart';

import '../../../core/styles/app_color.dart';
import '../../../core/utils/utils.dart';
import '../products_model/product_model.dart';
import '../user_model/user_model.dart';

class OrderModel {
  int? id;
  Status? status;
  String? totalAmount;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? trackingNumber;
  int? userId;
  UserModel? user;
  List<OrderItem>? orderItems;

  OrderModel({
    this.trackingNumber,
    this.id,
    this.user,
    this.status,
    this.totalAmount,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final basePrice = json['totalAmount'] != null
        ? double.tryParse(json['totalAmount']) ?? 0
        : 0;
    final tenPercent = basePrice * 0.1;
    final finalPrice = basePrice + tenPercent;
    return OrderModel(
      id: json['id'],
      status: json['status'] != null ? toStatus(json['status']) : null,
      totalAmount: finalPrice.toString(),
      paymentStatus: json['paymentStatus'],
      userId: json['userId'],
      trackingNumber: json["trackingNumber"],
      orderItems: json['orderItems'] != null
          ? parseList(json['orderItems'], OrderItem.fromJson)
          : null,
      user: json['user'] != null ? UserModel.fromJson(json["user"]) : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': fromStatus(status ?? Status.pending),
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userId': userId,
      'orderItems': orderItems?.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderItem {
  int? id;
  double? totalAmount;
  int? productId;
  int? orderId;
  int? quantity;
  double? price;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  OrderItem({
    this.id,
    this.totalAmount,
    this.productId,
    this.orderId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final basePrice = json['price']?.toDouble() ?? 0;
    final tenPercent = basePrice * 0.1;
    final finalPrice = basePrice + tenPercent;
    return OrderItem(
      id: json['id'],
      totalAmount: json['totalAmount']?.toDouble(),
      productId: json['productId'],
      orderId: json['orderId'],
      quantity: json['quantity'],
      price: finalPrice,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalAmount': totalAmount,
      'productId': productId,
      'orderId': orderId,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

enum Status {
  all,
  pending,
  accepted,
  rejected,
  inProgress,
  requested,
  completed,
  started,
  verified,
  booked,
  paid,
  active,
  suspend,
  approved,
  unpaid,
  suspendedUser,
  notVerifiedByAdmin,
  verifiedByAdmin,
}

String fromStatus(Status status) {
  switch (status) {
    case Status.all:
      return "ALL";
    case Status.pending:
      return "PENDING";
    case Status.accepted:
      return "ACCEPTED";
    case Status.rejected:
      return "REJECTED";
    case Status.inProgress:
      return "INPROGRESS";
    case Status.requested:
      return "REQUESTED";
    case Status.completed:
      return "COMPLETED";
    case Status.started:
      return "STARTED";
    case Status.verified:
      return "VERIFIED";
    case Status.booked:
      return "BOOKED";
    case Status.paid:
      return "PAID";
    case Status.active:
      return "ACTIVE";
    case Status.suspend:
      return "SUSPEND";
    case Status.approved:
      return "APPROVED";
    case Status.unpaid:
      return "UNPAID";
    case Status.suspendedUser:
      return "SUSPENDED_USER";
    case Status.notVerifiedByAdmin:
      return "NOT_VERIFIED_BY_ADMIN";
    case Status.verifiedByAdmin:
      return "VERIFIED_BY_ADMIN";
  }
}

Status toStatus(String status) {
  switch (status) {
    case "ALL":
      return Status.all;
    case "PENDING":
      return Status.pending;
    case "ACCEPTED":
      return Status.accepted;
    case "REJECTED":
      return Status.rejected;
    case "INPROGRESS":
      return Status.inProgress;
    case "REQUESTED":
      return Status.requested;
    case "COMPLETED":
      return Status.completed;
    case "STARTED":
      return Status.started;
    case "VERIFIED":
      return Status.verified;
    case "BOOKED":
      return Status.booked;
    case "PAID":
      return Status.paid;
    case "ACTIVE":
      return Status.active;
    case "SUSPEND":
      return Status.suspend;
    case "APPROVED":
      return Status.approved;
    case "UNPAID":
      return Status.unpaid;
    case "SUSPENDED_USER":
      return Status.suspendedUser;
    case "NOT_VERIFIED_BY_ADMIN":
      return Status.notVerifiedByAdmin;
    case "VERIFIED_BY_ADMIN":
      return Status.verifiedByAdmin;
    default:
      throw ArgumentError("Invalid status: $status");
  }
}

Color getOrderChipColor(Status status) {
  switch (status) {
    case Status.pending:
      return AppColors.darkBlue;
    case Status.inProgress:
      return AppColors.yellow;
    case Status.completed:
      return AppColors.green;
    case Status.rejected:
      return AppColors.red;
    default:
      return AppColors.darkBlue;
  }
}

String getOrderChipText(Status status) {
  switch (status) {
    case Status.pending:
      return "Pending";
    case Status.inProgress:
      return "In Progress";
    case Status.completed:
      return "Completed";
    case Status.rejected:
      return "Cancelled";
    default:
      return "Pending";
  }
}
