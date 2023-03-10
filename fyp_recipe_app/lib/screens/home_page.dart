import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/custom_widget/bottom_nav_bar.dart';

import '../custom_widget/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(20),
        child: Stack(children: [
          Column(children: [
            const TopBar(
              title: 'Browse for some recipes',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(
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
                )
              ]),
            ),
          ]),
        ]),
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
  const RecipeTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
