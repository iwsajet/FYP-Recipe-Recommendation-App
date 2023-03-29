import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/screens/search_result_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: const InputDecoration(
        labelText: 'Search',
        
      ),
      onSubmitted: (String keyword) {
        //searchRecipe(keyword);
      },
    );
  }
}
