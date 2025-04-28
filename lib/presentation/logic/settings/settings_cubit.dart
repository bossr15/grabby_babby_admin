import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/data/repositories/user_repository/user_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/home/side_panel/side_panel_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/settings/settings_state.dart';
import '../../../initializer.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final userRepository = UserRepository();
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();

  SettingsCubit() : super(SettingsState.empty()) {
    setUser();
  }

  void updateProfile(BuildContext context) {
    final isNotValid = fullName.text.isEmpty &&
        state.profileUrl.isEmpty &&
        phoneNumber.text.isEmpty;
    if (isNotValid) {
      showCustomSnackbar(
          context: context, message: "Update Name, phone or picture");
      return;
    }
    emit(state.copyWith(isLoading: true));
    userRepository
        .updateUser(
          fullName: fullName.text,
          phoneNumber: phoneNumber.text,
          url: state.profileUrl,
        )
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
              showCustomSnackbar(
                  context: context, message: error, type: SnackbarType.error);
            },
            (user) {
              emit(state.copyWith(user: user, isLoading: false));
              context.read<SidePanelCubit>().setUser(user);
            },
          ),
        );
  }

  void resetState() {
    fullName.clear();
    phoneNumber.clear();
    currentPassword.clear();
    newPassword.clear();
    state.profileUrl = "";
    setUser();
  }

  void setUser() {
    final user = localStorage.getUser();
    fullName.text = user.fullName ?? "";
    state.profileUrl = user.url ?? "";
    phoneNumber.text = user.phoneNumber ?? "";
    emit(state.copyWith(user: user, profileUrl: state.profileUrl));
  }

  void setProfileUrl(String image) {
    emit(state.copyWith(profileUrl: image));
  }

  void updatePassword(BuildContext context) {
    emit(state.copyWith(isPasswordLoading: true));
    userRepository
        .changePassword(
          currentPassword: currentPassword.text,
          newPassword: newPassword.text,
        )
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isPasswordLoading: false));
              showCustomSnackbar(
                  context: context, message: error, type: SnackbarType.error);
            },
            (user) {
              emit(state.copyWith(isPasswordLoading: false));
              showCustomSnackbar(
                  context: context,
                  message: "Password updated successfully",
                  type: SnackbarType.success);
              resetState();
            },
          ),
        );
  }

  void toggleIsChangeingPassword() {
    emit(state.copyWith(isChangingPassword: !state.isChangingPassword));
  }
}
