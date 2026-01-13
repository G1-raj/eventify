import 'package:eventify/features/auth/signup/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupControllerProvider = AsyncNotifierProvider<SingupController, void>(
  SingupController.new);

class SingupController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signup({
    required String email,
    required String username,
    required String fullName,
    required String password,
    required String role,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(authRepositoryProvider).signup(
            email: email,
            username: username,
            fullName: fullName,
            password: password,
            role: role,
          );
    });
  }
}