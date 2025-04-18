import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class AuthState {
  bool isObscureText;
  bool isLoading;
  String email;
  String password;
  UserModel user;
  AuthState({
    this.isObscureText = false,
    this.isLoading = false,
    this.email = "",
    this.password = "",
    UserModel? user,
  }) : user = user ?? UserModel();

  factory AuthState.initial() => AuthState();

  AuthState copyWith({
    bool? isObscureText,
    String? email,
    String? password,
    bool? isLoading,
    UserModel? user,
  }) {
    return AuthState(
      isObscureText: isObscureText ?? this.isObscureText,
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      password: this.password,
      user: user ?? this.user,
    );
  }
}
