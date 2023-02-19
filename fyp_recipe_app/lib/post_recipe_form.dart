import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'app_properties.dart';

class PostRecipe extends StatefulWidget {
  const PostRecipe({super.key});

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              TopBar(),
              Container(
                padding: const EdgeInsets.all(30),
                  margin:  EdgeInsets.only(top: 120, ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  //width: MediaQuery.of(context).size.height / 2.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),),
                      child: Form(child: Column(
                        children: [
                          Container(

                          )
                        ],
                      ),),
              ),
            ],
          )
        ]),
      ),
    );
  }
}