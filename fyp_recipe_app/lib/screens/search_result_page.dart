import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/sort_button.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';
import 'package:provider/provider.dart';
import '../custom_widget/search_bar.dart';
import '../models/recipe_model.dart';
import '../network/http_client.dart';
import '../services/auth_service.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late final TextEditingController searchController;
  //  final RecipeSearchHttpClient httpClient = RecipeSearchHttpClient();
  //   final AuthService authService = AuthService(client: httpClient);
  List<dynamic> recipes = [];
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: SearchBarWidget(
          searchController: searchController,
        )),
        body: Consumer<GetSearchProvider>(builder: (context, value, child) {
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              // RecipeModel recipe = GetSearchProvider(authService: authService).recipe[index];
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RecipePage()));
                },
              );
            },
          );
        }));
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipedata});
  final RecipeModel recipedata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RecipePage()));
      },
      child: Row(
        children: [
          //image
          //?
          Image.network(
            "src",
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width / 3,
            height: 100,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          // : const SizedBox(),
          //name or title of recipe
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("data")],
            ),
          ))
        ],
      ),
    );
  }
}
