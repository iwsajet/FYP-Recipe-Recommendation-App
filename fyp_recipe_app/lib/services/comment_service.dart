import '../Network/api_const.dart';
import '../models/comment_model.dart';
import '../network/http_client.dart';

class CommentService {
  late final RecipeSearchHttpClient _client;

  CommentService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
  Future<CommentModel> commentRecipe({
    required String comment,
    required String recipeId,
    required String userId,

  }) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipe/$recipeId/comment",
      body: {
        'comment': comment,
        'userId': userId,

      },
    );
    return CommentModel.fromJson(response);
  }

  Future<CommentModel> getcommentRecipe(
      {required String comment, required String recipeId}) async {
    final response = await _client.get(
      url: "${ApiConst.baseURL}recipe/$recipeId/comments",
    );
    return CommentModel.fromJson(response);
  }
}
