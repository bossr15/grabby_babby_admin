import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import '../../../../data/repositories/subscription_plan_repository/subscription_plan_repository.dart';
import 'add_subscription_plan_state.dart';

class AddSubscriptionPlanCubit extends Cubit<AddSubscriptionPlanState> {
  final planRepository = SubscriptionPlanRepository();
  AddSubscriptionPlanCubit() : super(AddSubscriptionPlanState.initial());

  void addPreferences(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    planRepository.addPlan(subscription: state.plan).then(
          (preferences) => preferences.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
              showCustomSnackbar(
                context: context,
                message: error,
                type: SnackbarType.error,
              );
            },
            (data) {
              showCustomSnackbar(
                context: context,
                message: 'Plan added successfully',
                type: SnackbarType.success,
              );
              AppNavigation.pop<bool>(true);
            },
          ),
        );
  }

  void updateState() {
    emit(state.copyWith(plan: state.plan));
  }

  void setUserRole(String role) {
    state.plan.role = role;
    emit(state);
  }

  void resetState() {
    emit(AddSubscriptionPlanState.initial());
  }
}
