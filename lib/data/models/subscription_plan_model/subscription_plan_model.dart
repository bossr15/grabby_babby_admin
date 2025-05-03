class SubscriptionPlanModel {
  int? id;
  String? title;
  String? description;
  int? duration;
  double? price;
  String? stripePlanId;
  String? stripeProductId;
  bool? isActive;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubscriptionPlanModel({
    this.id,
    this.role = "BUYER",
    this.title,
    this.description,
    this.duration,
    this.price,
    this.stripePlanId,
    this.stripeProductId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      stripePlanId: json['stripePlanId'] as String?,
      role: json['role'] as String?,
      stripeProductId: json['stripeProductId'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
      'price': price,
      'role': role,
      'stripePlanId': stripePlanId,
      'stripeProductId': stripeProductId,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'price': price,
      'role': role,
      'stripePlanId': stripePlanId,
      'stripeProductId': stripeProductId,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
