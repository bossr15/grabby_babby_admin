import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class SettingsState {
  UserModel user;
  String profileUrl;
  bool isLoading;

  SettingsState({
    required this.user,
    this.profileUrl = "",
    this.isLoading = false,
  });

  factory SettingsState.empty() => SettingsState(user: UserModel());

  copyWith({
    UserModel? user,
    bool? isLoading,
    String? profileUrl,
  }) =>
      SettingsState(
        profileUrl: profileUrl ?? this.profileUrl,
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
      );
}
