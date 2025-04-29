import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/subscription_plan_repository/subscription_plan_repository.dart';
import 'subscription_plan_state.dart';

class SubscriptionPlanCubit extends Cubit<SubscriptionPlanState> {
  final planRepository = SubscriptionPlanRepository();
  SubscriptionPlanCubit() : super(SubscriptionPlanState.initial()) {
    getPlans();
  }

  void getPlans() {
    emit(state.copyWith(isLoading: true));
    planRepository.getPlans().then(
          (plans) => plans.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, plans: data));
            },
          ),
        );
  }
}
