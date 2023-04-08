import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';

import '../services/rate_service.dart';


class RateRecipeProvider with ChangeNotifier {
  late final RateService _rateService;

  RateRecipeProvider({required RateService rateService}) {
    _rateService = rateService;
  }
  ApiResponse<void> rateResponse = ApiResponse.loading();
  Future<void> rate({required String recipeID, required double rating}) async {
    try {
      final response =
          await _rateService.rateRecipe(recipeId: recipeID, rating: rating);
      rateResponse = ApiResponse.success(null);
      notifyListeners();
    } catch (e) {
      rateResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
