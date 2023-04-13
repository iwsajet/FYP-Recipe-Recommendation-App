import '../Network/api_const.dart';
import '../models/recipe_model.dart';
import '../network/http_client.dart';

class SearchService {
  late final RecipeSearchHttpClient _client;

  SearchService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
  Future<List<RecipeModel>> searchRecipe({
    required List<String> ingredientNames,
  }) async {
    final keywordString = ingredientNames.join(',');
    final response = await _client.get(
        url: "${ApiConst.baseURL}searchByIngredient?keyword=$keywordString");

    return (response as List<dynamic>)
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
