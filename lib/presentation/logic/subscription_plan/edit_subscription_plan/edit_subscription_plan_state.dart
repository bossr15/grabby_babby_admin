import 'package:grabby_babby_admin/data/models/subscription_plan_model/subscription_plan_model.dart';

class EditSubscriptionPlanState {
  SubscriptionPlanModel plan;
  bool isLoading;
  bool fetchingPlan;
  EditSubscriptionPlanState({
    required this.plan,
    this.isLoading = false,
    this.fetchingPlan = false,
  });

  factory EditSubscriptionPlanState.initial() =>
      EditSubscriptionPlanState(plan: SubscriptionPlanModel());

  EditSubscriptionPlanState copyWith({
    SubscriptionPlanModel? plan,
    bool? isLoading,
    bool? fetchingPlan,
  }) {
    return EditSubscriptionPlanState(
      fetchingPlan: fetchingPlan ?? this.fetchingPlan,
      plan: plan ?? this.plan,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
