import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/models/subscription_plan_model/subscription_plan_model.dart';
import '../../../core/utils/utils.dart';
import '../../../initializer.dart';

class SubscriptionPlanRepository {
  Future<Either<String, List<SubscriptionPlanModel>>> getPlans({
    Map<String, dynamic>? extraQuery,
  }) async {
    final response = await networkRepository.get(
      url: "/plans/get-plans",
      extraQuery: extraQuery,
    );

    if (!response.failed) {
      final data =
          parseList(response.data["data"], SubscriptionPlanModel.fromJson);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, SubscriptionPlanModel>> addPlan(
      {required SubscriptionPlanModel subscription}) async {
    final response = await networkRepository.post(
        url: "/plans/add-plan", data: subscription.toJson());

    if (!response.failed) {
      final data = SubscriptionPlanModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, SubscriptionPlanModel>> updatePlan(
      {required SubscriptionPlanModel subscription}) async {
    final response = await networkRepository.put(
      url: "/plans/update-plan/${subscription.id}",
      data: subscription.toUpdateJson(),
    );

    if (!response.failed) {
      final data = SubscriptionPlanModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, SubscriptionPlanModel>> getPlanById(
      {required String id}) async {
    final response =
        await networkRepository.get(url: "/plans/get-plan-by-id/$id");

    if (!response.failed) {
      final data = SubscriptionPlanModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, SubscriptionPlanModel>> deletePlan(
      {required String id}) async {
    final response =
        await networkRepository.delete(url: "/plans/remove-plan/$id");

    if (!response.failed) {
      final data = SubscriptionPlanModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }
}
