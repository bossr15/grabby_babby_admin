import 'package:grabby_babby_admin/data/models/subscription_plan_model/subscription_plan_model.dart';

class AddSubscriptionPlanState {
  SubscriptionPlanModel plan;
  bool isLoading;

  AddSubscriptionPlanState({
    required this.plan,
    this.isLoading = false,
  });

  factory AddSubscriptionPlanState.initial() => AddSubscriptionPlanState(
        plan: SubscriptionPlanModel(),
      );

  AddSubscriptionPlanState copyWith({
    SubscriptionPlanModel? plan,
    bool? isLoading,
  }) {
    return AddSubscriptionPlanState(
      plan: plan ?? this.plan,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
