import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/models/products_model/product_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';
import 'package:grabby_babby_admin/data/repositories/user_repository/user_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_detail/user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  final String userId;
  final String accountType;
  UserDetailCubit({required this.userId, required this.accountType})
      : super(UserDetailState.initial()) {
    if (accountType == "BUYER") {
      fetchBuyerDetail();
    } else {
      fetchSellerDetail();
      fetchRevenue();
    }
  }

  UserModel get user => accountType == "BUYER"
      ? state.buyerDetail.buyer
      : state.sellerDetail.seller;

  List<ProductModel> get products => accountType == "BUYER"
      ? state.buyerDetail.products
      : state.sellerDetail.products;

  final userRepository = UserRepository();

  void fetchBuyerDetail() {
    emit(state.copyWith(isLoading: true));
    userRepository.getBuyerDetail(id: userId).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, buyerDetail: data));
            },
          ),
        );
  }

  void fetchSellerDetail() {
    emit(state.copyWith(isLoading: true));
    userRepository.getSellerDetail(id: userId).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, sellerDetail: data));
            },
          ),
        );
  }

  void fetchRevenue() {
    emit(state.copyWith(isRevenueLoading: true));
    userRepository
        .getSellerRevenueStats(
            userId: userId, filter: state.revenueFilter.toLowerCase())
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isRevenueLoading: false));
            },
            (data) {
              emit(state.copyWith(isRevenueLoading: false, revenueModel: data));
            },
          ),
        );
  }

  void setRevenueFilter(String filter) async {
    emit(state.copyWith(revenueFilter: filter));
    fetchRevenue();
  }
}
