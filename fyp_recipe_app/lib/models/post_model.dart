import 'package:flutter/cupertino.dart';

import 'ingredient_model.dart';

class Users {
  Users({
    this.recipePic,
    this.id,
    required this.name,
    required this.type,
    required this.ingredients,
    required this.instruction,
    required this.preptime,
    required this.imageUrl,
    this.originalUrl,
  });
  Image? recipePic;
  int? id;
  String name;
  String type;
  List<Ingredient> ingredients;
  List<String> instruction;
  int preptime;
  String imageUrl;
  String? originalUrl;
}
