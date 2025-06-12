import 'package:flutter/material.dart';

import '../order_model/order_model.dart';
import '../paginate/paginate.dart';

enum UserRole { buyer, seller, businessSeller, admin }

String fromRole(UserRole role) {
  switch (role) {
    case UserRole.admin:
      return "ADMIN";
    case UserRole.buyer:
      return "BUYER";
    case UserRole.seller:
      return "SELLER";
    case UserRole.businessSeller:
      return "BUSINESS SELLER";
  }
}

UserRole toRole(String role) {
  switch (role) {
    case "ADMIN":
      return UserRole.admin;
    case "BUYER":
      return UserRole.buyer;
    case "SELLER":
      return UserRole.seller;
    case "BUSINESSSELLER":
      return UserRole.businessSeller;
    default:
      return UserRole.buyer;
  }
}

class UserViewModel {
  ScrollController scrollController;
  bool isScrolling;
  bool isLoading;
  Paginate<UserModel> users;

  UserViewModel({
    this.isScrolling = false,
    this.isLoading = false,
    ScrollController? scrollController,
    Paginate<UserModel>? users,
  })  : users = Paginate<UserModel>.empty(),
        scrollController = ScrollController();
}

class UserModel {
  int? id;
  String? email;
  String? fullName;
  String? password;
  String? role;
  int? locationId;
  String? url;
  String? provider;
  bool? isVerifiedByAdmin;
  Status? status;
  String? businessName;
  String? businessProfile;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? abn;
  String? acn;
  String? phoneNumber;
  String? phoneCode;

  UserModel({
    this.id,
    this.email,
    this.fullName,
    this.password,
    this.role,
    this.locationId,
    this.url,
    this.provider,
    this.isVerifiedByAdmin,
    this.status,
    this.businessName,
    this.businessProfile,
    this.createdAt,
    this.updatedAt,
    this.abn,
    this.acn,
    this.phoneNumber,
    this.phoneCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      locationId: json['locationId'] as int?,
      url: json['url'] as String?,
      provider: json['provider'] as String?,
      isVerifiedByAdmin: json['isVerifiedByAdmin'] as bool?,
      status: json['status'] != null ? toStatus(json['status']) : null,
      businessName: json['businessName'] as String?,
      businessProfile: json['businessProfile'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      abn: json['ABN'] as String?,
      acn: json['ACN'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneCode: json['phoneCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'password': password,
      'role': role,
      'url': url,
      'status': fromStatus(status ?? Status.pending),
      'businessName': businessName,
      'businessProfile': businessProfile,
      'ABN': abn,
      'ACN': acn,
      'phoneNumber': phoneNumber,
      'phoneCode': phoneCode,
    };
  }

  String get roleName => fromRole(toRole(role ?? "BUYER"));
}
