
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';

import '../models/recipe_model.dart';

import '../network/api_response.dart';
import '../services/sort_service.dart';


class SortProvider with ChangeNotifier {
  late final SortService _sortService;
  SortProvider({required SortService sortService}) {
    _sortService = sortService;
  }

  ApiResponse<RecipeModel> sortResponse = ApiResponse.loading();
  Future<void> getUser() async {
    try {
      final response = await _sortService.sortRecipe();
      sortResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      sortResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}