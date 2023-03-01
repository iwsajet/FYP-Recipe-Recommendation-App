import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fyp_recipe_app/custom_widget/bottom_nav_bar.dart';
import 'package:fyp_recipe_app/post_recipe_form.dart';
import 'package:fyp_recipe_app/profile_page.dart';

import 'custom_widget/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          TopBar(
            title: 'Browse for some recipes',
          ),
          Container(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // HomePageCards(
                //     title: "Recommended", assets: 'assets/icons/ratings.png')
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image(image: AssetImage('assets/icons/ratings.png')),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image(image: AssetImage('assets/icons/ratings.png')),
                )
              ],
            ),
          ),
          SizedBox(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80',
                      ),
                    ),
                    Text("data")
                  ],
                ),
              )
            ],
          ))
        ]),
      ),
    );
  }
}

class HomePageCards extends StatelessWidget {
  const HomePageCards({super.key, required this.title, required this.assets});
  final String title;
  final String assets;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 20,
      width: 30,
      child: Row(children: [
        Image(
          image: AssetImage(
            assets,
          ),
        ),
        Text(title)
      ]),
    );
  }
}
