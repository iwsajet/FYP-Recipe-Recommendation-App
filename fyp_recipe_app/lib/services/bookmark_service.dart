import '../Network/api_const.dart';
import '../models/bookmark_model.dart';
import '../models/recipe_model.dart';
import '../network/http_client.dart';

class BookmarkService {
  late final RecipeSearchHttpClient _client;

  BookmarkService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
  Future<BookmarkModel> bookmarkRecipe(
      {required String userId, required String recipeID}) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}bookmark",
      body: {'userId': userId.toString(), 'recipeId': recipeID.toString()},
    );
    print(response);
    return BookmarkModel.fromJson(response);
  }

  Future<List<RecipeModel>> getbookmarkRecipe({required String userId}) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}bookmarks/$userId",
    );
    print(response);
    return (response['recipes'] as List<dynamic>)
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
