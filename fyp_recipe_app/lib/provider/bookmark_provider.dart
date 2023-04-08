import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/bookmark_service.dart';

import '../models/recipe_model.dart';

class BookmarkProvider with ChangeNotifier {
  late final BookmarkService _bookmarkService;

  BookmarkProvider({required BookmarkService bookmarkService}) {
    _bookmarkService = bookmarkService;
  }
  ApiResponse<void> bookmarkResponse = ApiResponse.loading();
  Future<void> bookmark(
      {required String recipeID, required String userId}) async {
    try {
      final response = await _bookmarkService.bookmarkRecipe(
        recipeID: recipeID,
        userId: userId,
      );
      bookmarkResponse = ApiResponse.success(null);
      notifyListeners();
    } catch (e) {
      bookmarkResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}

class GetBookmarkProvider with ChangeNotifier {
  late final BookmarkService _bookmarkService;

  GetBookmarkProvider({required BookmarkService bookmarkService}) {
    _bookmarkService = bookmarkService;
  }
  ApiResponse<List<RecipeModel>> getbookmarkResponse = ApiResponse.loading();
  Future<void> getbookmark(
      {required String recipeID, required String userId}) async {
    try {
      final response =
          await _bookmarkService.getbookmarkRecipe(recipeID: '', userId: '');
      getbookmarkResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      getbookmarkResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
