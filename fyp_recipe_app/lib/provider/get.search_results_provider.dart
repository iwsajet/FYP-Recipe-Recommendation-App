import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';

import '../services/auth_service.dart';

class GetSearchProvider with ChangeNotifier {
  late final AuthService _authService;
  GetSearchProvider({required AuthService authService}) {
    _authService = authService;
  }
  ApiResponse<List<RecipeModel>> getSearchResponse = ApiResponse.loading();

  Future<void> searchRecipe(
      {
      //File? recipePic,
      required String keyword}) async {
    try {
      await _authService.searchRecipe(keyword: keyword);
    } catch (e) {
      getSearchResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
