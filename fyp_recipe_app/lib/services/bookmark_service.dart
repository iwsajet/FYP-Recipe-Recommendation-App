import '../Network/api_const.dart';
import '../models/recipe_model.dart';
import '../models/report_model.dart';
import '../network/http_client.dart';

class BookmarkService {
  late final RecipeSearchHttpClient _client;

  BookmarkService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
  Future<ReportModel> bookmarkRecipe(
      {required String userId, required String recipeID}) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}bookmark",
      body: {'userId': userId, 'recipeId': recipeID},
    );
    return ReportModel.fromJson(response);
  }

  Future<List<RecipeModel>> getbookmarkRecipe(
      {required String userId, required String recipeID}) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}bookmarks/$userId",
    );
    return (response as List<dynamic>)
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
