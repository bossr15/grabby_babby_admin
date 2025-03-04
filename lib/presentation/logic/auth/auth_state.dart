class AuthState {
  bool isObscureText;
  AuthState({this.isObscureText = false});

  factory AuthState.initial() => AuthState();

  AuthState copyWith({bool? isObscureText}) {
    return AuthState(isObscureText: isObscureText ?? this.isObscureText);
  }
}
