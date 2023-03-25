import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: const InputDecoration(
        labelText: 'Search',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
