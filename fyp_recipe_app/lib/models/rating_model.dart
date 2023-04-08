class RateModel {
  String recipeId;
  num? rating;
  RateModel({required this.recipeId, this.rating});

  factory RateModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return RateModel(recipeId: map['recpieId'], rating: map['rating']);
  }
}
