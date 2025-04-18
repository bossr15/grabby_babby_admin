import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/auth_repository/auth_repository.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/presentation/logic/auth/auth_state.dart';

import '../../../navigation/route_name.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
  final authRepository = AuthRepository();

  void toggleObscureText() {
    emit(state.copyWith(isObscureText: !state.isObscureText));
  }

  void login(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    authRepository.login(email: state.email, password: state.password).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (data) {
              emit(state.copyWith(isLoading: false, user: data));
              AppNavigation.pushReplacementNamed(context, RouteName.dashboard);
            },
          ),
        );
  }
}
