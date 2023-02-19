import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.primary,
        appBarTheme: AppBarTheme(color: AppColor.secondary),
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
