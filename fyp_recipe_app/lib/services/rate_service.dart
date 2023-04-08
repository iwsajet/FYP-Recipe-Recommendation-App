import '../Network/api_const.dart';
import '../models/rating_model.dart';
import '../models/recipe_model.dart';
import '../network/http_client.dart';

class RateService {
  late final RecipeSearchHttpClient _client;

  RateService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
   
  Future<RateModel> rateRecipe(
      {required String recipeId, required double rating}) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipe/$recipeId/ratings",
      body: {'recipeId': recipeId, 'rating': rating},
    );

    return RateModel.fromJson(response);
  
  }}