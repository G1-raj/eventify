import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio;

  AuthApiService(this.dio);

  Future<void> signup({
    required String email,
    required String username,
    required String fullName,
    required String password,
    required String role
  }) async {
    try {

      await dio.post(
        "/auth/signup", 
        queryParameters: {
          "role": role
        },
        data: {
          "email": email.trim(),
          "username": username.trim(),
          "full_name": fullName.trim(),
          "password": password.trim(),
          "profile_pic": null
        }
      );
      
    } catch (e) {
      print("Error is: $e");
    }
  }
}