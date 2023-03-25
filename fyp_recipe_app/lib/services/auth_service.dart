import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/http_client.dart';
import 'package:fyp_recipe_app/screens/post_recipe_form.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';
import '../models/recipe_model.dart';
import '../network/api_const.dart';

class AuthService {
  late final RecipeSearchHttpClient _client;

  AuthService({required RecipeSearchHttpClient client}) {
    _client = client;
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await _client.post(url: "${ApiConst.baseURL}logIn", body: {
      'email': email,
      'password': password,
    });

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

  Future<RecipeModel> postRecipe({
    required String recipePic,
    required String name,
    required List<String> ingredients,
    required List<String> instruction,
    required String description,
    required String preptime,
    required String type,
  }) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}postRecipe",
      body: {
        'recipePic': recipePic,
        'name': name,
        'type': type,
        'ingredients': ingredients,
        'description': description,
        'preptime': preptime,
        'instruction': instruction
      },
    );
    return RecipeModel.fromJson(response);
  }
  Future<RecipeModel> getRecipe({
   required String recipePic,
    required String name,
    required List<String> ingredients,
    required List<String> instruction,
    required String description,
    required String preptime,
    required String type, required String imageURL,
}) async{
   final response = await _client.get(
      url: "${ApiConst.baseURL}getRecipe",
     
    );
    return RecipeModel.fromJson(response);
}

Future<void> searchRecipe({
   required String recipePic,
    required String name,
    required List<String> ingredients,
    required List<String> instruction,
    required String description,
    required String preptime,
    required String type,
})async{
  final response = await _client.get(url: "${ApiConst.baseURL}searchRecipe?keyword=keyword");
}
}
