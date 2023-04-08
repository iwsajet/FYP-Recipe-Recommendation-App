import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/custom_widget/bottom_nav_bar.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/screens/recipelist_screen.dart';
import 'package:fyp_recipe_app/screens/recipetype_screen.dart';
import 'package:fyp_recipe_app/screens/search_result_page.dart';
import 'package:provider/provider.dart';
import '../custom_widget/top_bar.dart';
import '../models/recipe_typeModel.dart';
import '../provider/recipe_type_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController searchController;
  late final GetSearchProvider searchProvider;
  @override
  void initState() {
    searchController = TextEditingController();
    searchProvider = context.read<GetSearchProvider>();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: CustomScrollView(
        // padding: const EdgeInsets.all(20),
        slivers: [
          const SliverToBoxAdapter(
            child: TopBar(
              title: 'Browse for some recipes',
            ),
          ),
          SliverToBoxAdapter(
              child: GestureDetector(
            child: Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.secondary),
                    color: Colors.white),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: AppColor.secondary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                          color: AppColor.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchResult()));
            },
          )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    child: const HomePageCards(
                      image: 'assets/icons/ratings.png',
                      title: 'Recommended',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RecipeList()));
                    },
                  ),
                  GestureDetector(
                    child: const HomePageCards(
                      image: 'assets/icons/quality.png',
                      title: 'Top Rated',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RecipeList()));
                    },
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: recipeTypes
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RecipeListView()));
                          context
                              .read<GetRecipeByTypeProvider>()
                              .getRecipebyType(keyword: e.title);
                        },
                        child:
                            RecipeTypeCard(image: e.imageurl, title: e.title),
                      ),
                    )
                    .toList()),
          ))
        ],
      ),
    );
  }
}

class HomePageCards extends StatelessWidget {
  const HomePageCards({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: AppColor.secondary),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class RecipeTypeCard extends StatelessWidget {
  const RecipeTypeCard({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: AppColor.secondary),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset(
              image,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
