import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/provider/recipe_type_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../network/api_const.dart';

class RecipeListView extends StatefulWidget {
  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  List<dynamic> recipes = [];

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recipes'),
        ),
        body:
            Consumer<GetRecipeByTypeProvider>(builder: (context, value, child) {
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              // RecipeModel recipe = GetRecipeByTypeProvider(authService: authService).recipes[index];
              final recipe = recipes[index];
              return ListTile(
                leading: Image.network(recipe['imageURL']),
                title: Text(recipe['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe['type']),
                    Text(recipe['description']),
                    Text('Prep Time: ${recipe['preptime'].toString()} minutes'),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // navigate to recipe detail page
                },
              );
            },
          );
        }));
  }
}
