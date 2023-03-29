import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';

class ReportProvider with ChangeNotifier {
  late final AuthService _authService;

  ReportProvider({required AuthService authService}) {
    _authService = authService;
  }
  ApiResponse<void> postResponse = ApiResponse.loading();
  Future<void> report(
      {required String fullname,
      required String report}) async {
    try {
      await _authService.reportRecipe(
       
       fullname: fullname, report: report
      );
    } catch (e) {
      postResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
