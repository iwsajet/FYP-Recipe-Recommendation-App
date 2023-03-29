import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';

class CommentProvider with ChangeNotifier {
  late final AuthService _authService;

  CommentProvider({required AuthService authService}) {
    _authService = authService;
  }
  ApiResponse<void> postResponse = ApiResponse.loading();
  Future<void> report(
      {required String fullname,
      required String comment}) async {
    try {
      await _authService.commentRecipe(
       
       fullname: fullname, comment: comment
      );
    } catch (e) {
      postResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
