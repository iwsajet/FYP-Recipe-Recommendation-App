import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/provider/get_recipe_provider.dart';

import 'package:fyp_recipe_app/screens/recipe_page.dart';
import 'package:provider/provider.dart';
import '../network/api_response.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: ,
            ),
        body: Consumer<GetRecipeTopCardProvider>(
            builder: (context, value, child) {
          if (value.getRecipeTopCardResponse.status == Status.success) {
            final recipes = value.getRecipeTopCardResponse.data!;
            ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  final recipe = recipes[index];
                  return ListTile(
                    leading: recipe.imageURL != null
                        ? Image.network(recipe.imageURL!.startsWith('http')
                            ? recipe.imageURL!
                            : 'http://192.168.1.126:3000' + recipe.imageURL!)
                        : const Icon(Icons.image_not_supported),
                    title: Text(recipe.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.recipeType),
                        Text(recipe.description),
                        Text(
                            'Prep Time: ${recipe.preptime.toString()} minutes'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecipePage(
                                clickedrecipe: recipes[index],
                              )));
                    },
                  );
                });
          }
          return const SizedBox();
        }));
  }
}
