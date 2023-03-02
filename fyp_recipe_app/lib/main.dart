import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/screens/home_page.dart';
import 'package:fyp_recipe_app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_recipe_app/screens/post_recipe_form.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PostRecipe(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.primary,
        appBarTheme: const AppBarTheme(color: AppColor.secondary),
        //bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.secondary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.secondary),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColor.secondary),
        ),
      ),
    );
  }
}
