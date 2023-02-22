import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/post_recipe_form.dart';
import 'package:fyp_recipe_app/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: IconTheme(
          data: const IconThemeData(),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: (() {}),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostRecipe(),
                    ),
                  );
                }),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserProfile(),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
