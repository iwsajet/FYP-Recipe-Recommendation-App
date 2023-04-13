

import '../Network/api_const.dart';
import '../models/recipe_model.dart';
import '../network/http_client.dart';

class PostService{
   late final RecipeSearchHttpClient _client;

  PostService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
 Future<RecipeModel> postRecipe({
    //required File? recipePic,
    required String name,
    required String userId,
    required List<Map<String, dynamic>> ingredients,
    required List<String> instruction,
    required String description,
    required String preptime,
    required String type,
  }) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipes/postRecipe",
      body: {
        userId: userId,
        'name': name,
        'type': type,
        'ingredients': ingredients,
        'description': description,
        'preptime': preptime,
        'instruction': instruction
      },
    );
    return RecipeModel.fromJson(response);
  }

}