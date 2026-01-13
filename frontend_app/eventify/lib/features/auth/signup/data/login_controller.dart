import 'package:eventify/features/auth/signup/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = AsyncNotifierProvider<LoginController, void>(LoginController.new);

class LoginController extends AsyncNotifier<void>{
  @override
  Future<void> build() async {}

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(authRepositoryProvider).login(email: email, password: password);
    });

  }
}