import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';


class PostRecipe extends StatefulWidget {
  const PostRecipe({super.key});

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {
  late final TextEditingController _recipeName;
  late final TextEditingController _ingredients;
  late final TextEditingController _description;
  late final TextEditingController _preparationTime;
  late final TextEditingController _instructions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              const TopBar(),
              Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.only(
                  top: 120,
                ),
                height: MediaQuery.of(context).size.height / 1.8,
                //width: MediaQuery.of(context).size.height / 2.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () {},
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                          child: TextFormField(
                            controller: _recipeName,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),),
                      
                      Container(
                        child: TextFormField(
                          controller: _description,
                            decoration:
                                const InputDecoration(labelText: "Description"),
                            maxLength: 300),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _ingredients,
                          decoration: const InputDecoration(
                            labelText: "Ingredients",
                          ),
                          maxLength: 300,
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _preparationTime,
                          decoration: const InputDecoration(
                              labelText: "Preparation time",
                              hintText: "Rough estimate on preparation time"),
                              
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _instructions,
                          decoration:
                              const InputDecoration(labelText: "Instructions"),
                              maxLength: 300
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          child: const Text("Post"),
                          onPressed: () {
                            final food = <String, dynamic>{
                              "name": _recipeName,
                              "description": _description,
                              "ingredients": _ingredients,
                              "preparation time": _preparationTime,
                              "instructions": _instructions
                            };

                            FirebaseFirestore.instance
                                .collection("Recipes")
                                .doc()
                                .set(food)
                                .onError((e, _) =>
                                    print("Error writing document: $e"));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
