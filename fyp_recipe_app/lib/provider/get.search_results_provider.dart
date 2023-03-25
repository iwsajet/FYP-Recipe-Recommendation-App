import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/network/api_response.dart';

import '../services/auth_service.dart';

class GetSearchProvider with ChangeNotifier{
  late final AuthService _authService; 
  GetSearchProvider({required AuthService authService}){
    _authService = authService;
  }
   ApiResponse<void> getSearchResponse = ApiResponse.loading();

  Future<void>searchRecipe({
     File? recipePic,
      required String name,
      required String type,
      required String description,
      required List<String> ingredients,
      required String preptime,
      required List<String> instruction
  })async{
     try {
      await _authService.getRecipe(
          description: '',
          ingredients: [],
          instruction: [],
          name: '',
          preptime: '',
          recipePic: '',
          type: '', imageURL: '');
    } catch (e) {getSearchResponse = ApiResponse.error(e.toString());
    notifyListeners();}
  }
}