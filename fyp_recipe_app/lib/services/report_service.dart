import '../Network/api_const.dart';
import '../models/report_model.dart';
import '../network/http_client.dart';

class ReportService {
  late final RecipeSearchHttpClient _client;

  ReportService({required RecipeSearchHttpClient client}) {
    _client = client;
  }

  Future<ReportModel> reportRecipe(
      {required String fullname,
      required String report,
      required String recipeId}) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipe/$recipeId/report",
      body: {'fullname': fullname, 'report': report, 'recipeId': recipeId},
    );
    return ReportModel.fromJson(response);
  }
}
