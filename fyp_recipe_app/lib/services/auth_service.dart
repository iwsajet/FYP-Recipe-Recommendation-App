import 'package:fyp_recipe_app/network/http_client.dart';

import '../models/user_model.dart';

class AuthService {
  late final RecipeSearchHttpClient _client;

  AuthService({required RecipeSearchHttpClient client}) {
    _client = client;
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    final response =
        await _client.post(url: "http://192.168.1.108:3000/logIn", body: {
      'email': email,
      'password': password,
    });

    return UserModel.fromJson(response);
  }

  Future signUp({required String email, required String password}) async {
    final response =
        await _client.post(url: "http://192.168.1.108:3000/signUp", body: {
      'email': email,
      'password': password,
      
    });

    print("resposne is $response");
  }
}
