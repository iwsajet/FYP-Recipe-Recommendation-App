import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/custom_widget/bottom_nav_bar.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/screens/search_result_page.dart';
import 'package:provider/provider.dart';

import '../custom_widget/search_bar.dart';
import '../custom_widget/top_bar.dart';
import '../network/api_response.dart';

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
    searchProvider.addListener(searchListner);
    super.initState();
  }
@override
  void dispose() {
   searchController.dispose();
    super.dispose();
  }
  void searchListner() {
    if (searchProvider.getSearchResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(searchProvider.getSearchResponse.error.toString())));
    } else if (searchProvider.getSearchResponse.status == Status.success) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const SearchResult())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: CustomScrollView(
        // padding: const EdgeInsets.all(20),
        slivers: [
          const SliverToBoxAdapter(
            child: TopBar(
              title: 'Browse for some recipes',
            ),
          ),
          SliverToBoxAdapter(
            child: SearchBarWidget(
              searchController: searchController,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  HomePageCards(
                    image: 'assets/icons/ratings.png',
                    title: 'Recommended',
                  ),
                  HomePageCards(
                    image: 'assets/icons/quality.png',
                    title: 'Top Rated',
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
              children: const [
                RecipeTypeCard(
                    image: 'assets/icons/breakfast.png', title: "Breakfast"),
                RecipeTypeCard(image: 'assets/icons/meal.png', title: "Lunch"),
                RecipeTypeCard(
                    image: 'assets/icons/dinner.png', title: "Dinner"),
                RecipeTypeCard(image: 'assets/icons/bake.png', title: "Baking"),
                RecipeTypeCard(
                    image: 'assets/icons/hot-soup.png', title: "Soup"),
                RecipeTypeCard(image: 'assets/icons/diet.png', title: "Diet")
              ],
            ),
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
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColor.secondary),
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
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
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
      child: GestureDetector(
        onTap: () {},
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColor.secondary),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
