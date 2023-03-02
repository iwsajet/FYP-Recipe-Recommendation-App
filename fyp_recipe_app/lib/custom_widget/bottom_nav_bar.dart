import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_recipe_app/screens/profile_page.dart';

import '../screens/home_page.dart';
import '../screens/post_recipe_form.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IconTheme(
        data: const IconThemeData(),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: (() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }),
            ),
            const SizedBox(
              width: 50,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: (() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PostRecipe(),
                  ),
                );
              }),
            ),
            const SizedBox(
              width: 50,
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: (() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserProfile(),
                  ),
                );
              }),
            ),
            const SizedBox(
              width: 50,
            ),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout)),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
