import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/screens/profile_page.dart';

import '../network/http_client.dart';
import '../screens/home_page.dart';
import '../screens/login_page.dart';
import '../screens/post_recipe_form.dart';
import '../services/auth_service.dart';

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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
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

class Logout extends StatefulWidget {
  final AuthService authService;
  const Logout({super.key, required this.authService});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  late final RecipeSearchHttpClient client;
  @override
  void initState() {
    super.initState();
    client = widget.authService.client;
  }

  void _handleLogout() async {
    await widget.authService.logout();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          _handleLogout();
        },
        icon: const Icon(Icons.logout));
  }
}
