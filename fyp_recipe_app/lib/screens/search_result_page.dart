import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/sort_button.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';

import '../custom_widget/search_bar.dart';
import '../models/recipe_model.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SearchBarWidget(
            searchController: searchController,
          ),
          const SortByDropdown(),
          ListView(),
        ],
      )),
    );
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
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
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
