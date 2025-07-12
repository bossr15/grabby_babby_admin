import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/debouncer.dart';
import 'package:grabby_babby_admin/data/models/paginate/paginate.dart';
import '../../../data/models/order_model/order_model.dart';
import '../../../data/repositories/product_repository/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final productRepository = ProductRepository();
  final debouncer = Debouncer();

  ProductCubit() : super(ProductState.empty()) {
    state.products.forEach((key, value) {
      fetchProducts(key);
      attachListener(status: key);
    });
  }

  void fetchData({bool refresh = false}) {
    state.products
        .forEach((key, value) => fetchProducts(key, refresh: refresh));
  }

  void attachListener({required Status status}) {
    state.products[status]!.scrollController.addListener(() {
      if (state.products[status]!.scrollController.position.pixels >
          state.products[status]!.scrollController.position.maxScrollExtent -
              200) {
        if (!state.products[status]!.isScrolling &&
            state.products[status]!.products.currentPage <
                state.products[status]!.products.totalPages) {
          goToNextPage(status: status);
        }
      }
    });
  }

  void goToNextPage({required Status status}) {
    state.products[status]!.products.currentPage++;
    state.products[status]!.isScrolling = true;
    emit(state);
    fetchProducts(status);
  }

  void fetchProducts(Status status, {bool refresh = false}) {
    state.products[status]!.isLoading = true;
    if (refresh) state.products[status]!.products = Paginate.empty();
    emit(state.copyWith(products: state.products));
    final extraQuery = {
      if (state.search.isNotEmpty) 'search': state.search,
    };
    productRepository
        .getAllProducts(
            previousData: state.products[status]!.products,
            extraQuery: extraQuery,
            status: status)
        .then(
          (response) => response.fold(
            (error) {
              state.products[status]!.isLoading = false;
              state.products[status]!.isScrolling = false;
              emit(state.copyWith(products: state.products));
            },
            (data) {
              state.products[status]!.isLoading = false;
              state.products[status]!.isScrolling = false;
              state.products[status]!.products = data;
              emit(state.copyWith(products: state.products));
            },
          ),
        );
  }

  void searchProducts(String query) {
    state.search = query;
    debouncer.call(() => fetchData(refresh: true));
  }

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void updatProductstatus({
    required String id,
    required Status status,
  }) {
    productRepository.updateProductStatus(id: id, status: status).then(
          (response) => response.fold(
            (error) {},
            (data) => fetchData(refresh: true),
          ),
        );
  }
}
