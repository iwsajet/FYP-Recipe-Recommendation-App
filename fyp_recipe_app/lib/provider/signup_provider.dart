
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import '../services/auth_service.dart';

class SignUpProvider with ChangeNotifier {
  late final AuthService _authService;

  SignUpProvider({required AuthService authService}) {
    _authService = authService;
  }

  ApiResponse<void> apiResponse = ApiResponse.loading();

  Future<void> signUp({
    required String email,
    required String password,
    required String fullname
  }) async {
    try {
      await _authService.signUp(
        email: email,
        password: password,
        fullname: fullname
      );
      apiResponse = ApiResponse.success(null);
      notifyListeners();
    } catch (e) {
      apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
