

import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/post_service.dart';

class PostRecipeProvider with ChangeNotifier {
  late final PostService _postService;

  PostRecipeProvider({required PostService postService}) {
    _postService = postService;
  }
  ApiResponse<void> postResponse = ApiResponse.loading();
  Future<void> postRecipe({
    required String userId,
    required String? recipePic,
    required String name,
    required String type,
    required String description,
    required List<Map<String, dynamic>> ingredients,
    required String preptime,
    required List<String> instruction,
  }) async {
    try {
      await _postService.postRecipe(
        userId: userId,
        name: name,
        type: type,
        description: description,
        ingredients: ingredients,
        instruction: instruction,
        preptime: preptime,
      );
    } catch (e) {
      postResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
