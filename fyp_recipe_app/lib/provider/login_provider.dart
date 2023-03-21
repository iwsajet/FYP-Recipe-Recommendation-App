import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../network/api_response.dart';
import '../screens/home_page.dart';
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
