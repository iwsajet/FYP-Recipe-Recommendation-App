import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //dish image
            Container(),
            //recipe name, posted by, description
            Container(),
            // rating
            Container(),
            //prepatation time serving size ingredients
            Container(),
            //instruction
            Container(),
            //comments
            Container()
          ],
        ),

      )
    );
  }
}