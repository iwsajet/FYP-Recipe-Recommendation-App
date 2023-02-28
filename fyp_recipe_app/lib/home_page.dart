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
        child: Column(

            //   slivers: [
            // SliverToBoxAdapter(
            children: [
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        image: NetworkImage(
                          'https://cdn.dribbble.com/users/86429/screenshots/7896133/media/a21c84e96e37754d3e8e25ed92011fc5.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
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
            ]
            // )),
            // SliverToBoxAdapter(
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Image(height: 30,
            //       width: 30,
            //         image: NetworkImage(
            //             'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80', ),
            //       ),
            //       Image(
            //         height: 30,
            //       width: 30,
            //         image: NetworkImage(
            //             'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80'),
            //       ),
            //        Image(height: 30,
            //       width: 30,
            //         image: NetworkImage(
            //             'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80', ),
            //       ),
            //       Image(
            //         height: 30,
            //       width: 30,
            //         image: NetworkImage(
            //             'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1780&q=80'),
            //       ),
            //     ],
            //   ),
            // )
            //   ],
            // )
            ),
      ),
    );
  }
}
