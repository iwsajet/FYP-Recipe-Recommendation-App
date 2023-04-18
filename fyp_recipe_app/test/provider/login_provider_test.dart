import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/network/http_client.dart';
import 'package:fyp_recipe_app/models/user_model.dart';
import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    // Mock of the login response
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'passtest@gmail.com') {
      return UserModel(
        id: "123",
        email: email,
        password: password,
        fullname: "abc",
      );
    }
    throw Exception("Error");
  }

  Future<List<RecipeModel>> searchPosts({required String keyword}) {
    throw UnimplementedError();
  }

  @override
  Future signUp(
      {required String email,
      required String password,
      required String fullname}) {
    throw UnimplementedError();
  }

  @override
  RecipeSearchHttpClient get client => throw UnimplementedError();

  @override
  Future<UserModel> logout() {
    throw UnimplementedError();
  }
}

void main() {
  group('LoginProvider', () {
    late LoginProvider loginProvider;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      loginProvider = LoginProvider(authService: mockAuthService);
    });

    test(
        'login() should have loginResponse as ApiResponse.success on successful login',
        () async {
      const email = 'passtest@gmail.com';
      const password = 'password';

      await loginProvider.login(email: email, password: password);

      expect(loginProvider.loginResponse.status, equals(Status.success));
      expect(loginProvider.loginResponse.data, isA<UserModel>());
      expect(loginProvider.loginResponse.error, isNull);
    });

    test(
        'login() should have loginResponse as ApiResponse.error on failed login',
        () async {
      const email = 'failtest@example.com';
      const password = 'wrong_password';

      await loginProvider.login(email: email, password: password);

      expect(loginProvider.loginResponse.status, equals(Status.error));
      expect(loginProvider.loginResponse.data, isNull);
      expect(loginProvider.loginResponse.error, isNotNull);
    });
  });
}
