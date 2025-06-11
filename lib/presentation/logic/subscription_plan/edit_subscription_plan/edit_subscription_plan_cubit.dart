import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../data/repositories/subscription_plan_repository/subscription_plan_repository.dart';
import 'edit_subscription_plan_state.dart';

class EditSubscriptionPlanCubit extends Cubit<EditSubscriptionPlanState> {
  final planRepository = SubscriptionPlanRepository();
  String planId;
  EditSubscriptionPlanCubit({required this.planId})
      : super(EditSubscriptionPlanState.initial()) {
    getPreferencesById();
  }

  void getPreferencesById() {
    emit(state.copyWith(fetchingPlan: true));
    planRepository.getPlanById(id: planId).then(
          (plan) => plan.fold(
            (error) {
              emit(state.copyWith(fetchingPlan: false));
            },
            (data) {
              emit(state.copyWith(plan: data, fetchingPlan: false));
            },
          ),
        );
  }

  void editPlan(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    planRepository.updatePlan(subscription: state.plan).then(
          (plan) => plan.fold(
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
                message: 'Plan updated successfully',
                type: SnackbarType.success,
              );
              emit(state.copyWith(isLoading: false, plan: data));
              AppNavigation.pop<bool>(true);
            },
          ),
        );
  }

  void setUserRole(String role) {
    state.plan.role = role;
    emit(state);
  }

  void updateState() {
    emit(state.copyWith(plan: state.plan));
  }

  void resetState() {
    emit(EditSubscriptionPlanState.initial());
    getPreferencesById();
  }
}
