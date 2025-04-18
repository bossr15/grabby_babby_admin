import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../initializer.dart';
import '../../models/user_model/user_model.dart';

class AuthRepository {
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await networkRepository
        .post(url: "/auth/login", data: {"email": email, "password": password});
    if (!response.failed) {
      final data = UserModel.fromJson(response.data["data"]);
      if ("ADMIN" != data.role) {
        // meaning the user is right now in the flow of another role and has entered the credentials of another role
        localStorage.remove("token");
        return left("Invalid credentials!");
      }
      localStorage.setString("user", jsonEncode(data.toJson()));
      return right(data);
    }
    return left(response.message);
  }
}
