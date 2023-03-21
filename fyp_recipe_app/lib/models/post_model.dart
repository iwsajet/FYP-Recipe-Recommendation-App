import 'package:flutter/cupertino.dart';

import 'ingredient_model.dart';

class RecipeModel {
  RecipeModel({
    this.recipePic,
    this.id,
    required this.name,
    required this.recipeType,
    required this.ingredients,
    required this.instruction,
    required this.preptime,
    // required this.imageUrl,
    // this.originalUrl,
  });
  Image? recipePic;
  int? id;
  String name;
  String recipeType;
  List<Ingredient> ingredients;
  List<String> instruction;
  String preptime;
  // String? imageUrl;
  // String? originalUrl;

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
      recipePic: map['recipePic'],
      name: map['name'],
      recipeType: map['type'],
      ingredients: map['ingredients'],
      instruction: map['instructions'],
    preptime: map['preptime'],
    // imageUrl: map['imageUrl'] 
     );
  }
}
