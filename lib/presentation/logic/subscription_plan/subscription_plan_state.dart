import 'package:grabby_babby_admin/data/models/subscription_plan_model/subscription_plan_model.dart';

class SubscriptionPlanState {
  List<SubscriptionPlanModel> plans;
  bool isLoading;
  SubscriptionPlanState({
    required this.plans,
    this.isLoading = false,
  });

  factory SubscriptionPlanState.initial() => SubscriptionPlanState(plans: []);

  SubscriptionPlanState copyWith(
      {List<SubscriptionPlanModel>? plans, bool? isLoading}) {
    return SubscriptionPlanState(
      plans: plans ?? this.plans,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
