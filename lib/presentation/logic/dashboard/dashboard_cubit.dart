import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/dashboard/dashboard_state.dart';

import '../../../data/repositories/dashboard_repository/dashboard_repository.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.empty()) {
    fetchDashboardStats();
  }

  final dashBoardRepository = DashBoardRepository();

  void fetchDashboardStats() {
    emit(state.copyWith(isLoading: true));
    dashBoardRepository.getDashboardStats().then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, dashboardStats: data));
            },
          ),
        );
  }
}
