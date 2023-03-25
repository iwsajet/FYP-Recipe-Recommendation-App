import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/network/http_client.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/provider/get_recipe_provider.dart';
import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:fyp_recipe_app/provider/post_recipe_provider.dart';
import 'package:fyp_recipe_app/provider/signup_provider.dart';
import 'package:fyp_recipe_app/screens/first_screen.dart';
import 'package:fyp_recipe_app/screens/home_page.dart';
import 'package:fyp_recipe_app/screens/login_page.dart';
import 'package:fyp_recipe_app/screens/post_recipe_form.dart';
import 'package:fyp_recipe_app/screens/recipe_page.dart';
import 'package:fyp_recipe_app/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  final RecipeSearchHttpClient httpClient = RecipeSearchHttpClient();
  final AuthService authService = AuthService(client: httpClient);
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authService});
  final AuthService authService;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(authService: authService),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(authService: authService),
        ),
        ChangeNotifierProvider<PostRecipeProvider>(
            create: (context) =>
                PostRecipeProvider(authService: authService)),
        // ChangeNotifierProvider<GetRecipeProvider>(
        //     create: (context) => GetRecipeProvider(authService: authService)),
        // ChangeNotifierProvider<GetSearchProvider>(
        //     create: (context) => GetSearchProvider(authService: authService))
      ],
      child: MaterialApp(
        home: const HomePage(),
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
