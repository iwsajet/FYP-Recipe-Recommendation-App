import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../network/api_response.dart';
import '../services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider({required AuthService authService}) {
    _authService = authService;
  }

  late final AuthService _authService;

  ApiResponse<UserModel> loginResponse = ApiResponse.loading();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await _authService.login(email: email, password: password);

      loginResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      loginResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}

class LogoutProvider with ChangeNotifier {
  LogoutProvider({required AuthService authService}) {
    _authService = authService;
  }

  late final AuthService _authService;

  ApiResponse<UserModel> logoutResponse = ApiResponse.loading();

  Future<void> login({required String userId}) async {
    try {
      final response = await _authService.logout();

      logoutResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      logoutResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
