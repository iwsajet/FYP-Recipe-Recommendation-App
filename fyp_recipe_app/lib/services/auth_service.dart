

import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/http_client.dart';
import '../models/user_model.dart';
import '../network/api_const.dart';

class AuthService {
  late final RecipeSearchHttpClient _client;

  AuthService({required RecipeSearchHttpClient client}) {
    _client = client;

  }
RecipeSearchHttpClient get client => _client;
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await _client.post(url: "${ApiConst.baseURL}logIn", body: {
      'email': email,
      'password': password,
    });
    print(response);
    return UserModel.fromJson((response as Map<String, dynamic>)['user']);
  }

  Future signUp({
    required String email,
    required String password,
    required String fullname,
  }) async {
    final response = await _client.post(
        url: "${ApiConst.baseURL}signUp",
        body: {'email': email, 'password': password, 'fullname': fullname});

    print("response is $response");
  }

 Future<UserModel> logout(
      // {required String userId}
      ) async {
    final response = await _client.post(url: "${ApiConst.baseURL}logout", body: {
    //'userId': userId,
    });
    print(response);
    return UserModel.fromJson((response as Map<String, dynamic>)['user']);
  }

}
