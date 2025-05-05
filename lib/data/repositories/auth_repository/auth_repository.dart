import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/repositories/user_repository/user_repository.dart';
import '../../../initializer.dart';
import '../../models/user_model/user_model.dart';

class AuthRepository {
  final userRepository = UserRepository();

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
      userRepository.updateFcmToken();

      return right(data);
    }
    return left(response.message);
  }

  Future<Either<String, bool>> forgotPassowrd({required String email}) async {
    final response = await networkRepository
        .put(url: "/auth/forget-password", data: {"email": email});
    if (!response.failed) {
      return right(true);
    }
    return left(response.message);
  }

  Future<Either<String, UserModel>> verifyOtp(
      {required String email, required int otp}) async {
    final response =
        await networkRepository.post(url: "/auth/verified-email", data: {
      "email": email,
      "otp": otp,
    });
    if (!response.failed) {
      final data = response.data["data"];
      final user = UserModel.fromJson(data);
      localStorage.setString("user", jsonEncode(user.toJson()));
      return right(user);
    }
    return left(response.message);
  }

  Future<Either<String, bool>> updatePassword(
      {required String password}) async {
    final response = await networkRepository
        .post(url: "/auth/update-password", data: {"newPassword": password});
    if (!response.failed) {
      return right(true);
    }
    return left(response.message);
  }
}
