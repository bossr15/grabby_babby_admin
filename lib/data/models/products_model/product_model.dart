import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/data/models/order_model/order_model.dart';

import '../../../core/utils/utils.dart';
import '../paginate/paginate.dart';

class ProductModel {
  int? id;
  double? price;
  String? overview;
  String? name;
  String? category;
  String? state;
  int? quantity;
  double? gst;
  double? discount;
  Status? status;
  String? productType;
  int? userId;
  double? postage;
  String? productCondition;
  String? createdAt;
  String? updatedAt;
  List<String>? images;
  ProductMetaData? productMetaData;

  ProductModel({
    this.id,
    this.price,
    this.overview,
    this.name,
    this.category,
    this.state,
    this.quantity,
    this.gst = 0,
    this.discount,
    this.status,
    this.productType,
    this.userId,
    this.postage,
    this.productCondition,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.productMetaData,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final basePrice = json['price']?.toDouble() ?? 0;
    final tenPercent = basePrice * 0.1;
    final finalPrice = basePrice + tenPercent;
    return ProductModel(
      id: json['id'],
      price: finalPrice,
      overview: json['overview'],
      name: json['name'],
      category: json['category'],
      state: json['state'],
      quantity: json['quantity'],
      gst: json['GST']?.toDouble(),
      discount: json['discount']?.toDouble(),
      status: toStatus(json['status']),
      productType: json['productType'],
      userId: json['userId'],
      postage: json['postage']?.toDouble(),
      productCondition: json['productCondition'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      images: parseList(json['images'], ProductImage.fromJson)
          .map((image) => image.url ?? "")
          .toList(),
      productMetaData: json['productMetaData'] != null
          ? ProductMetaData.fromJson(json['productMetaData'])
          : null,
    );
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      "id": id,
      'name': name,
      'overview': overview,
      "GST": gst,
      'price': price,
      'state': state,
      'productCondition': productCondition,
      'images': images,
    };
  }

  ProductModel copyWith({
    int? id,
    double? price,
    String? overview,
    String? name,
    String? category,
    String? state,
    int? quantity,
    double? gst,
    double? discount,
    Status? status,
    String? productType,
    int? userId,
    double? postage,
    String? productCondition,
    String? createdAt,
    String? updatedAt,
    List<String>? images,
    ProductMetaData? productMetaData,
  }) {
    return ProductModel(
      id: id ?? this.id,
      price: price ?? this.price,
      overview: overview ?? this.overview,
      name: name ?? this.name,
      category: category ?? this.category,
      state: state ?? this.state,
      quantity: quantity ?? this.quantity,
      gst: gst ?? this.gst,
      discount: discount ?? this.discount,
      status: status ?? this.status,
      productType: productType ?? this.productType,
      userId: userId ?? this.userId,
      postage: postage ?? this.postage,
      productCondition: productCondition ?? this.productCondition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      productMetaData: productMetaData ?? this.productMetaData,
    );
  }

  String get productImage => images?.firstOrNull ?? "";
  double get productRating => switch (productCondition) {
        "Brand New" => 5,
        'Opened but new condition' => 4,
        'Used' => 3,
        'Well Used' => 2,
        'Poor Condition' => 1,
        _ => 0,
      };
}

class ProductImage {
  int? id;
  int? productId;
  String? url;
  String? createdAt;
  String? updatedAt;

  ProductImage({
    this.id,
    this.productId,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['productId'],
      url: json['url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'url': url,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ProductImage copyWith({
    int? id,
    int? productId,
    String? url,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductImage(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductMetaData {
  int? id;
  int? productId;
  int? reviewsCount;
  double? rating;
  String? createdAt;
  String? updatedAt;

  ProductMetaData({
    this.id,
    this.productId,
    this.reviewsCount,
    this.rating,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductMetaData.fromJson(Map<String, dynamic> json) {
    return ProductMetaData(
      id: json['id'],
      productId: json['productId'],
      reviewsCount: json['reviewsCount'],
      rating: json['rating']?.toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'reviewsCount': reviewsCount,
      'rating': rating,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ProductMetaData copyWith({
    int? id,
    int? productId,
    int? reviewsCount,
    double? rating,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductMetaData(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductViewModel {
  ScrollController scrollController;
  bool isScrolling;
  bool isLoading;
  Paginate<ProductModel> products;

  ProductViewModel({
    this.isScrolling = false,
    this.isLoading = false,
    ScrollController? scrollController,
    Paginate<ProductModel>? products,
  })  : products = Paginate<ProductModel>.empty(),
        scrollController = ScrollController();
}
