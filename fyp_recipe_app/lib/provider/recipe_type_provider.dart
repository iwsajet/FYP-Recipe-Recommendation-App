import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';

import '../services/get_service.dart';

class GetRecipeByTypeProvider with ChangeNotifier {
  late final GetService _getService;
  GetRecipeByTypeProvider({required GetService getService}) {
    _getService = getService;
  }
  ApiResponse<List<RecipeModel>> getRecipeByTypeResponse =
      ApiResponse.loading();

  Future<void> getRecipebyType({required String keyword}) async {
    try {
      final response = await _getService.getRecipebyType(keyword: keyword);
      getRecipeByTypeResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      getRecipeByTypeResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
