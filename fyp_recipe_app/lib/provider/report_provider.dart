import 'package:flutter/cupertino.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/services/report_service.dart';

import '../models/report_model.dart';

class ReportProvider with ChangeNotifier {
  late final ReportService _reportService;

  ReportProvider({required ReportService reportService}) {
    _reportService = reportService;
  }
  ApiResponse<ReportModel> reportResponse = ApiResponse.loading();
  Future<void> report(
      {required String fullname,
      required String report,
      required String recipeId}) async {
    try {
      final response =await _reportService.reportRecipe(
       
       fullname: fullname, report: report, recipeId: recipeId
      );
      reportResponse = ApiResponse.success(response);
      notifyListeners();
    } catch (e) {
      reportResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
