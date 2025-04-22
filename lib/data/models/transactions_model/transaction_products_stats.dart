class TransactionProductsStats {
  String categoryName;
  int currentRevenue;
  int lastRevenue;
  int change;

  TransactionProductsStats({
    required this.categoryName,
    required this.currentRevenue,
    required this.lastRevenue,
    required this.change,
  });

  factory TransactionProductsStats.fromJson(Map<String, dynamic> json) {
    return TransactionProductsStats(
      categoryName: json["categoryName"],
      currentRevenue: json["currentRevenue"],
      lastRevenue: json["lastRevenue"],
      change: json["change"],
    );
  }
}
