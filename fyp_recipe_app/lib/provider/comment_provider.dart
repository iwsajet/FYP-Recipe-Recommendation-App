import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/comment_service.dart';

import '../models/comment_model.dart';

class CommentProvider with ChangeNotifier {
  late final CommentService _commentService;

  CommentProvider({required CommentService commentService}) {
    _commentService = commentService;
  }
  ApiResponse<CommentModel> commentResponse = ApiResponse.loading();
  Future<void> comment({
    required String comment,
    required String recipeId,
    required String userId,

  }) async {
    try {
      final response = await _commentService.commentRecipe(
        comment: comment,
        recipeId: recipeId,
        userId: userId,
 
      );
      commentResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      commentResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
