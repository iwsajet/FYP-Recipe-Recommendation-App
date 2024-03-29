import '../Network/api_const.dart';
import '../models/rating_model.dart';
import '../network/http_client.dart';
import 'package:mongo_dart/mongo_dart.dart';
class RateService {
  late final RecipeSearchHttpClient _client;

  RateService({required RecipeSearchHttpClient client}) {
    _client = client;
  }
   
  Future<RateModel> rateRecipe(
      {required String recipeId, required double rating}) async {
    final response = await _client.post(
      url: "${ApiConst.baseURL}recipe/$recipeId/ratings",
      body: {'recipeId': ObjectId.fromHexString(recipeId), 'rating': rating},
    );

    return RateModel.fromJson(response);
  
  }}