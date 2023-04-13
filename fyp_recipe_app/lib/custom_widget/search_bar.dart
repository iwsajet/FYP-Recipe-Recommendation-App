import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/get.search_results_provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          labelText: 'Search',
        ),
        onSubmitted: (String keyword) {
          context.read<GetSearchProvider>().searchRecipe(ingredientNames: []);
        },
      ),
    );
  }
}
