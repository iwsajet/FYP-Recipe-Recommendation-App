import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';

import '../models/recipe_model.dart';
import '../services/get_service.dart';

class UserPostProvider with ChangeNotifier {
  late final GetService _userService;

  UserPostProvider({required GetService userService}) {
    _userService = userService;
  }
  ApiResponse<List<RecipeModel>> userPostResponse = ApiResponse.loading();
  Future<void> userPost({required String userId}) async {
    try {
      final response = await _userService.getRecipesByUserId(userId: userId);
      userPostResponse = ApiResponse.success(response);

      notifyListeners();
    } on Exception catch (e) {
      userPostResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
