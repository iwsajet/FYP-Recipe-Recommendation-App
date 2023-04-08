import '../Network/api_const.dart';
import '../models/recipe_model.dart';
import '../network/http_client.dart';

class SortService {
  late final RecipeSearchHttpClient _client;

  SortService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
   
  Future<RecipeModel> sortRecipe() async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}sortRecipe",
    );
    return RecipeModel.fromJson(response);
  }}