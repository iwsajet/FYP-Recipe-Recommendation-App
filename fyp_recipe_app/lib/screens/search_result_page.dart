import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';

import '../models/post_model.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(),
      body: SingleChildScrollView(
        child: ListView(),
      ),
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
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          // : const SizedBox(),
          //name or title of recipe
          Flexible(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("data")
              ],
            ),
          ))
        ],
      ),
    );
  }
}

// class DropdownButtonExample extends StatefulWidget {
//   DropdownButtonExample({super.key});
//   List<String> list = <String>['By Rating', 'By Preparation Time'];

//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(
//         Icons.arrow_drop_down,
//         size: 37,
//         color: Colors.white,
//       ),
//       elevation: 4,
//       style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
//       underline: Container(
//         height: 2.5,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
