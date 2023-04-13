import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import '../services/search_service.dart';

class GetSearchProvider with ChangeNotifier {
  late final SearchService _searchService;
  GetSearchProvider({required SearchService searchService}) {
    _searchService = searchService;
  }
  ApiResponse<List<RecipeModel>> getSearchResponse = ApiResponse.loading();

  Future<void> searchRecipe({required List<String> ingredientNames,}) async {
    try {
      final response = await _searchService.searchRecipe(ingredientNames: ingredientNames );
      getSearchResponse = ApiResponse.success(response);
      notifyListeners();
    } on Exception {
      getSearchResponse = ApiResponse.error("Something went wrong");
      notifyListeners();
    }
  }
}
