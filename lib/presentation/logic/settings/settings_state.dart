import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class SettingsState {
  UserModel user;
  String profileUrl;
  bool isLoading;
  bool isPasswordLoading;
  bool isChangingPassword;

  SettingsState({
    required this.user,
    this.profileUrl = "",
    this.isLoading = false,
    this.isChangingPassword = false,
    this.isPasswordLoading = false,
  });

  factory SettingsState.empty() => SettingsState(user: UserModel());

  copyWith({
    UserModel? user,
    bool? isLoading,
    bool? isPasswordLoading,
    bool? isChangingPassword,
    String? profileUrl,
  }) =>
      SettingsState(
        profileUrl: profileUrl ?? this.profileUrl,
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        isPasswordLoading: isPasswordLoading ?? this.isPasswordLoading,
        isChangingPassword: isChangingPassword ?? this.isChangingPassword,
      );
}
