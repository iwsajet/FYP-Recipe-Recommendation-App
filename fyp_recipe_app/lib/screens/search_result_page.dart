import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/sort_button.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';
import 'package:provider/provider.dart';
import '../custom_widget/search_bar.dart';

import '../network/api_response.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late final TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Search',
            ),
            onSubmitted: (String ingredientNames) {
              context
                  .read<GetSearchProvider>()
                  .searchRecipe(ingredientNames: [ingredientNames]);
            },
          ),
          actions: const <Widget>[SortByDropdown()],
        ),
        body: Consumer<GetSearchProvider>(builder: (context, value, child) {
          if (value.getSearchResponse.status == Status.success) {
            final recipes = value.getSearchResponse.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                debugPrint("imageurl is ${recipe.imageURL}");
                return ListTile(
                  leading: SizedBox(
                    height: 100,
                    width: 100,
                    child: recipe.imageURL != null
                        ? Image.network(
                            recipe.imageURL!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                  ),
                  title: Text(recipe.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type:${recipe.recipeType}'),
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
