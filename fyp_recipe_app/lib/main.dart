import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/network/http_client.dart';
import 'package:fyp_recipe_app/provider/bookmark_provider.dart';
import 'package:fyp_recipe_app/provider/comment_provider.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/provider/get_recipe_provider.dart';

import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:fyp_recipe_app/provider/post_recipe_provider.dart';
import 'package:fyp_recipe_app/provider/rate_provider.dart';
import 'package:fyp_recipe_app/provider/recipe_type_provider.dart';
import 'package:fyp_recipe_app/provider/report_provider.dart';
import 'package:fyp_recipe_app/provider/signup_provider.dart';
import 'package:fyp_recipe_app/provider/sort_provider.dart';
import 'package:fyp_recipe_app/provider/user_post_provider.dart';
import 'package:fyp_recipe_app/screens/first_screen.dart';

import 'package:fyp_recipe_app/services/auth_service.dart';
import 'package:fyp_recipe_app/services/bookmark_service.dart';
import 'package:fyp_recipe_app/services/comment_service.dart';
import 'package:fyp_recipe_app/services/get_service.dart';
import 'package:fyp_recipe_app/services/post_service.dart';
import 'package:fyp_recipe_app/services/rate_service.dart';
import 'package:fyp_recipe_app/services/report_service.dart';
import 'package:fyp_recipe_app/services/search_service.dart';
import 'package:fyp_recipe_app/services/sort_service.dart';
import 'package:provider/provider.dart';

void main() async {
  final RecipeSearchHttpClient httpClient = RecipeSearchHttpClient();
  final AuthService authService = AuthService(client: httpClient);
  final PostService postService = PostService(client: httpClient);
  final GetService getService = GetService(client: httpClient);
  final CommentService commentService = CommentService(client: httpClient);
  final ReportService reportService = ReportService(client: httpClient);
  final BookmarkService bookmarkService = BookmarkService(client: httpClient);
  final SearchService searchService = SearchService(client: httpClient);
  final RateService rateService = RateService(client: httpClient);
  final SortService sortService = SortService(client: httpClient);

  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp(
      authService: authService,
      postService: postService,
      getService: getService,
      commentService: commentService,
      reportService: reportService,
      bookmarkService: bookmarkService,
      searchService: searchService,
      rateService: rateService,
      sortService: sortService));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.authService,
      required this.postService,
      required this.getService,
      required this.commentService,
      required this.reportService,
      required this.bookmarkService,
      required this.searchService,
      required this.rateService,
      required this.sortService}
      );
  final AuthService authService;
  final PostService postService;
  final GetService getService;
  final CommentService commentService;
  final ReportService reportService;
  final BookmarkService bookmarkService;
  final SearchService searchService;
  final RateService rateService;
  final SortService sortService;

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
            create: (context) => PostRecipeProvider(postService: postService)),
        ChangeNotifierProvider<GetRecipeProvider>(
            create: (context) => GetRecipeProvider(getService: getService)),
        ChangeNotifierProvider<GetSearchProvider>(
            create: (context) => GetSearchProvider(searchService: searchService)),
        ChangeNotifierProvider<ReportProvider>(
            create: (context) => ReportProvider(reportService: reportService)),
        ChangeNotifierProvider<CommentProvider>(
            create: (context) =>
                CommentProvider(commentService: commentService)),

        ChangeNotifierProvider<GetRecipeProvider>(
            create: (context) => GetRecipeProvider(getService: getService)),
        ChangeNotifierProvider<GetRecipeByTypeProvider>(
            create: (context) =>
                GetRecipeByTypeProvider(getService: getService)),
        ChangeNotifierProvider<GetRecipeTopCardProvider>(
            create: (context) =>
                GetRecipeTopCardProvider(getService: getService)),
        ChangeNotifierProvider<BookmarkProvider>(
            create: (context) =>
                BookmarkProvider(bookmarkService: bookmarkService)),
        ChangeNotifierProvider<GetBookmarkProvider>(
            create: (context) =>
                GetBookmarkProvider(bookmarkService: bookmarkService)),
        ChangeNotifierProvider<RateRecipeProvider>(
            create: (context) => RateRecipeProvider(rateService: rateService)),
              ChangeNotifierProvider<SortProvider>(
            create: (context) => SortProvider(sortService: sortService)),
          ChangeNotifierProvider<UserPostProvider>(
            create: (context) => UserPostProvider(userService: getService)),
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
