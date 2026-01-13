import 'package:eventify/core/network/dio_provider.dart';
import 'package:eventify/features/auth/signup/data/auth_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    AuthApiService(ref.read(dioProvider))
  );
});

class AuthRepository {
  final AuthApiService api;

  AuthRepository(this.api);

  Future<void> signup({
    required String email,
    required String username,
    required String fullName,
    required String password,
    required String role,
  }) {
    return api.signup(
      email: email,
      username: username,
      fullName: fullName,
      password: password,
      role: role,
    );
  }

  Future<void> login({required String email, required String password}) {
    return api.login(email: email, password: password);
  }
}