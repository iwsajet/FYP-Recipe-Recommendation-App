import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';

class GetRecipeProvider with ChangeNotifier {
  late final AuthService _authService;
  GetRecipeProvider({required AuthService authService}) {
    _authService = authService;
  }

  ApiResponse<RecipeModel> getRecipeResponse = ApiResponse.loading();
  Future<void> getRecipe(
      {
        required File? recipePic,
        required String imageURL, 
      required String name,
      required String type,
      required String description,
      required List<String> ingredients,
      required String preptime,
      required List<String> instruction}) async {
    try {
      await _authService.getRecipe(
        imageURL: '',
          description: '',
          ingredients: [],
          instruction: [],
          name: '',
          preptime: '',
          recipePic: '',
          type: '');
    } catch (e) {getRecipeResponse = ApiResponse.error(e.toString());
    notifyListeners();}
  }
}
