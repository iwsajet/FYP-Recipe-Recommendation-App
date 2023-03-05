import 'package:flutter/cupertino.dart';

class PostModel {
  String name;
  String description;
  String ingredients;
  String preparationTime;
  String instructions;
  Image photo;

  PostModel(
      {required this.name,
      required this.description,
      required this.ingredients,
      required this.preparationTime,
      required this.instructions,
      required this.photo});
}
