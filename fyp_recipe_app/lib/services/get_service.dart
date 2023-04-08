import '../Network/api_const.dart';
import '../models/recipe_model.dart';
import '../models/user_model.dart';
import '../network/http_client.dart';

class GetService {
  late final RecipeSearchHttpClient _client;

  GetService({required RecipeSearchHttpClient client}) {
    _client = client;
  }

  Future<RecipeModel> getRecipe() async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getRecipe",
    );
    return RecipeModel.fromJson(response);
  }

  Future<List<RecipeModel>> getRecipeTopCard() async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getRecipe",
    );
    return (response as List<dynamic>)
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<RecipeModel>> getRecipebyType({required String keyword}) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getByType?keyword=$keyword",
    );
    return (response as List<dynamic>)
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserModel> getUser() async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getUser",
    );
    return UserModel.fromJson(response);
   // return UserModel.fromJson(response.userId);
  }
  Future<List<RecipeModel>> getRecipesByUserId({required String userId}) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}getRecipesByUserId/$userId",
    );
    return (response as List<dynamic>)
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
