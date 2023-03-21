import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';

import '../models/post_model.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView());
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
