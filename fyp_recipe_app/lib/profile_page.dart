import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/home_page.dart';
import 'package:fyp_recipe_app/post_recipe_form.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                onPressed: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }),
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
                onPressed: (() {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
