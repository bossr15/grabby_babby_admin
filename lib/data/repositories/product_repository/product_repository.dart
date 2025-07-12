import 'package:dartz/dartz.dart';

import '../../../initializer.dart';
import '../../models/order_model/order_model.dart';
import '../../models/paginate/paginate.dart';
import '../../models/products_model/product_model.dart';

class ProductRepository {
  Future<Either<String, Paginate<ProductModel>>> getAllProducts({
    required Paginate<ProductModel> previousData,
    required Status status,
    Map<String, dynamic>? extraQuery,
  }) async {
    final response = await networkRepository.get(
      url: "/admin/get-all-product-list",
      extraQuery: {
        "status": fromStatus(status),
        ...?extraQuery,
      },
    );
    if (!response.failed) {
      final parsedData = Paginate<ProductModel>.mergePagination(
        previousData: previousData,
        newData: response.data,
        dataFromJson: ProductModel.fromJson,
        dataKey: "products",
      );
      return right(parsedData);
    }
    return left(response.message);
  }

  Future<Either<String, bool>> updateProductStatus(
      {required String id, required Status status}) async {
    final response = await networkRepository.post(
        url: "/admin/approved-reject-product",
        data: {"status": fromStatus(status), "id": id});
    if (!response.failed) {
      return right(true);
    }
    return left(response.message);
  }
}
