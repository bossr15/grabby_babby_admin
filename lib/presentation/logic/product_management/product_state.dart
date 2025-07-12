import '../../../data/models/order_model/order_model.dart';
import '../../../data/models/products_model/product_model.dart';

class ProductState {
  Map<Status, ProductViewModel> products;
  int selectedIndex;
  String search;

  ProductState({
    required this.products,
    this.selectedIndex = 0,
    this.search = "",
  });

  factory ProductState.empty() => ProductState(
        products: {
          Status.pending: ProductViewModel(),
          Status.approved: ProductViewModel(),
        },
      );

  copyWith({
    Map<Status, ProductViewModel>? products,
    int? selectedIndex,
    String? search,
  }) {
    return ProductState(
      products: products ?? this.products,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      search: search ?? this.search,
    );
  }
}
