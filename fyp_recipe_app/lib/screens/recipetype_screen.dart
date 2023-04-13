import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/provider/recipe_type_provider.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';
import 'package:provider/provider.dart';

import '../network/api_response.dart';

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recipes'),
        ),
        body:
            Consumer<GetRecipeByTypeProvider>(builder: (context, value, child) {
          if (value.getRecipeByTypeResponse.status == Status.success) {
            final recipes = value.getRecipeByTypeResponse.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    child: recipe.imageURL != null
                        ? Image.network(
                            recipe.imageURL!.startsWith('http')
                                ? recipe.imageURL!
                                : 'http://192.168.1.124:3000' +
                                    recipe.imageURL!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                  ),
                  title: Text(recipe.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type: ${recipe.recipeType}'),
                      Text('Description: ${recipe.description}'),
                      Text('Prep Time: ${recipe.preptime.toString()} minutes'),
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
              },
            );
          }
          return const SizedBox();
        }));
  }
}
