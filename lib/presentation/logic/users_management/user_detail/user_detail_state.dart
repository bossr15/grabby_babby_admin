import 'package:grabby_babby_admin/data/models/user_model/buyer_detail_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

import '../../../../data/models/revenue/revenue_model.dart';
import '../../../../data/models/user_model/seller_detail_model.dart';

class UserDetailState {
  BuyerDetailModel buyerDetail;
  SellerDetailModel sellerDetail;
  final RevenueModel revenueModel;
  bool isLoading;
  String revenueFilter;
  bool isRevenueLoading;

  UserDetailState({
    required this.buyerDetail,
    required this.sellerDetail,
    required this.revenueModel,
    this.isLoading = false,
    this.revenueFilter = 'Month',
    this.isRevenueLoading = false,
  });

  factory UserDetailState.initial() => UserDetailState(
        revenueModel: RevenueModel(
          totalRevenue: 0,
          revenueAxis: [],
        ),
        buyerDetail: BuyerDetailModel(buyer: UserModel(), products: []),
        sellerDetail: SellerDetailModel(
          seller: UserModel(),
          products: [],
          topSellingProducts: [],
          monthlySales: [],
          orders: [],
        ),
      );

  UserDetailState copyWith({
    BuyerDetailModel? buyerDetail,
    SellerDetailModel? sellerDetail,
    bool? isLoading,
    bool? isRevenueLoading,
    String? revenueFilter,
    RevenueModel? revenueModel,
  }) =>
      UserDetailState(
        buyerDetail: buyerDetail ?? this.buyerDetail,
        sellerDetail: sellerDetail ?? this.sellerDetail,
        revenueFilter: revenueFilter ?? this.revenueFilter,
        revenueModel: revenueModel ?? this.revenueModel,
        isLoading: isLoading ?? this.isLoading,
        isRevenueLoading: isRevenueLoading ?? this.isRevenueLoading,
      );
}
