import 'dart:io';

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
    required imageUrl,
    // required this.imageUrl,
  });
  File? recipePic;
  int? id;
  String name;
  String recipeType;
  List<RecipeIngredientModel> ingredients;
  List<String> instruction;
  int preptime;
  String? imageUrl;

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
        recipePic: map['recipePic'],
        name: map['name'],
        recipeType: map['type'],
        ingredients: (map['ingredients'] as List<dynamic>)
            .map((e) => RecipeIngredientModel.fromMap(e))
            .toList(),
        instruction: map['instructions'],
        preptime: map['preptime'],
        imageUrl: map['imageUrl']);
  }
}

class RecipeIngredientModel {
  final String name;
  final String quantity;

  RecipeIngredientModel({required this.name, required this.quantity});

  factory RecipeIngredientModel.fromMap(Map<String, dynamic> map) {
    return RecipeIngredientModel(name: map['name'], quantity: map['quantity']);
  }
}
