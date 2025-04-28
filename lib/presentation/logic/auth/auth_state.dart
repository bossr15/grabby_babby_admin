import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class AuthState {
  bool isObscureText;
  bool isLoading;
  String email;
  String password;
  String confirmPassword;
  UserModel user;

  AuthState({
    this.isObscureText = false,
    this.isLoading = false,
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    UserModel? user,
  }) : user = user ?? UserModel();

  factory AuthState.initial() => AuthState();

  AuthState copyWith({
    bool? isObscureText,
    String? email,
    String? password,
    bool? isLoading,
    UserModel? user,
    String? confirmPassword,
  }) {
    return AuthState(
      isObscureText: isObscureText ?? this.isObscureText,
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      password: this.password,
      user: user ?? this.user,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
