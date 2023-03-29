import 'dart:io';

import 'package:fyp_recipe_app/models/ingredient_model.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/models/report_model.dart';
import 'package:fyp_recipe_app/network/http_client.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';
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
    //required File? recipePic,
    required String name,
    required List<Map<String, dynamic>> ingredients,
    required List<String> instruction,
    required String description,
    required String preptime,
    required String type,
  }) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipes/postRecipe",
      body: {
        //'recipePic': recipePic,
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
    //required String recipePic,
    required String name,
    required List<Ingredient> ingredients,
    required List<String> instruction,
    required String description,
    required String preptime,
    required String type,
    required String imageURL,
  }) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getRecipe",
    );
    return RecipeModel.fromJson(response);
  }

  Future<RecipeModel> getRecipebyType(
      {
      required String keyword}) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getByType?keyword=$keyword",
    );
    return RecipeModel.fromJson(response);
  }

  Future<void> searchRecipe(
      {
      required String keyword}) async {
    final response = await _client.get(
        url: "${ApiConst.baseURL}searchRecipe?keyword=$keyword");
  }
Future<CommentModel> commentRecipe({
   required String fullname,
   required String comment
  }) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipes/:recipeId/comments",
      body: {
        'fullname': fullname,
        'comment': comment,
       
      },
    );
    return CommentModel.fromJson(response);
  }
Future<ReportModel> reportRecipe({
   required String fullname,
   required String report
  }) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipes/:recipeId/report",
      body: {
        'fullname': fullname,
        'report': report,
       
      },
    );
    return ReportModel.fromJson(response);
  }
  // Future<ReportModel> bookmarkRecipe({
 
  // }) async {
  //   final response = await _client.post(
  //     url: "${ApiConst.baseURL}bookmark",
  //     body: {
      
  //     },
  //   );
  //   return ReportModel.fromJson(response);
  // }
}
