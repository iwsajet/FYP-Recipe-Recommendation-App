

import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/get_service.dart';

class GetRecipeProvider with ChangeNotifier {
  late final GetService _getService;
  GetRecipeProvider({required GetService getService}) {
    _getService = getService;
  }

  ApiResponse<RecipeModel> getRecipeResponse = ApiResponse.loading();
  Future<void> getRecipe() async {
    try {
      final response = await _getService.getRecipe();
      getRecipeResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      getRecipeResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}

class GetRecipeTopCardProvider with ChangeNotifier {
  late final GetService _getService;
  GetRecipeTopCardProvider({required GetService getService}) {
    _getService = getService;
  }

  ApiResponse<List<RecipeModel>> getRecipeTopCardResponse = ApiResponse.loading();
  Future<void> getRecipeTopCard() async {
    try {
      final response = await _getService.getRecipeTopCard();
      getRecipeTopCardResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      getRecipeTopCardResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}

