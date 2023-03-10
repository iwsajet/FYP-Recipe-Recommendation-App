import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:fyp_recipe_app/provider/signup_provider.dart';
import 'package:fyp_recipe_app/screens/first_screen.dart';
import 'package:fyp_recipe_app/screens/home_page.dart';
import 'package:fyp_recipe_app/screens/login_page.dart';
import 'package:fyp_recipe_app/screens/post_recipe_form.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignupProvider>(create: (context) => SignupProvider()),
        Provider<LoginProvider>(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        home: const FirstScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.primary,
          appBarTheme: const AppBarTheme(color: AppColor.secondary),
          //bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.secondary),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColor.secondary),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColor.secondary),
          ),
        ),
      ),
    );
  }
}
