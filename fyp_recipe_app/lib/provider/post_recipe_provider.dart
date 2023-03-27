import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';

class PostRecipeProvider with ChangeNotifier {
  late final AuthService _authService;

  PostRecipeProvider({required AuthService authService}) {
    _authService = authService;
  }
  ApiResponse<void> postResponse = ApiResponse.loading();
  Future<void> postRecipe(
      {required File? recipePic,
      required String name,
      required String type,
      required String description,
      required List<Map<String, dynamic>> ingredients,
      required String preptime,
      required List<String> instruction}) async {
    try {
      await _authService.postRecipe(
        // recipePic: recipePic,
        name: name,
        type: type,
        description: description,
        ingredients: ingredients,
        instruction: instruction,
        preptime: preptime,
      );
    } catch (e) {
      postResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
