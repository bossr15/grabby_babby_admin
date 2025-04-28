import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/auth_repository/auth_repository.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/presentation/logic/auth/auth_state.dart';

import '../../../core/utils/utils.dart';
import '../../../navigation/route_name.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  final authRepository = AuthRepository();
  List<String> otp = <String>['', '', '', '', '', ''];

  void updateOTP(String digit, int index, BuildContext context) {
    if (index >= 0 && index < 6) {
      otp[index] = digit;
      if (index < 5 && digit.isNotEmpty) {
        FocusScope.of(context).nextFocus();
      }
    }
  }

  int getOTP() {
    return int.tryParse(otp.join()) ?? 0;
  }

  void removeDigit(int index) {
    if (index >= 0 && index < 6) {
      otp[index] = '';
    }
  }

  void toggleObscureText() {
    emit(state.copyWith(isObscureText: !state.isObscureText));
  }

  void login(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    authRepository.login(email: state.email, password: state.password).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
              showCustomSnackbar(
                  context: context, message: error, type: SnackbarType.error);
            },
            (data) {
              emit(state.copyWith(isLoading: false, user: data));
              AppNavigation.pushReplacementNamed(RouteName.dashboard);
            },
          ),
        );
  }

  void forgetPassword(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    authRepository
        .forgotPassowrd(email: state.email)
        .then((response) => response.fold(
              (error) {
                emit(state.copyWith(isLoading: false));
                showCustomSnackbar(
                    context: context, message: error, type: SnackbarType.error);
              },
              (data) {
                emit(state.copyWith(isLoading: false));
                AppNavigation.pushNamed(RouteName.verifyOtp,
                    pathParameters: {'email': state.email});
              },
            ));
  }

  void verifyOtp(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    authRepository
        .verifyOtp(email: "admin@gmail.com", otp: getOTP())
        .then((response) => response.fold(
              (error) {
                emit(state.copyWith(isLoading: false));
                showCustomSnackbar(
                    context: context, message: error, type: SnackbarType.error);
              },
              (data) {
                emit(state.copyWith(isLoading: false));
                AppNavigation.pop();
                AppNavigation.pushReplacementNamed(RouteName.newPassword);
              },
            ));
  }

  void updatePassword(BuildContext context) {
    emit(state.copyWith(isLoading: true));
    authRepository
        .updatePassword(password: state.password)
        .then((response) => response.fold(
              (error) {
                emit(state.copyWith(isLoading: false));
                showCustomSnackbar(
                    context: context, message: error, type: SnackbarType.error);
              },
              (data) {
                emit(state.copyWith(isLoading: false));
                AppNavigation.pushReplacementNamed(RouteName.dashboard);
              },
            ));
  }
}
