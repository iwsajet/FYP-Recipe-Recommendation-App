import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'package:image_picker/image_picker.dart';

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

  File? pickedImage;
  Future pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(
        () {
          pickedImage = tempImage;
        },
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    _recipeName = TextEditingController();
    _ingredients = TextEditingController();
    _description = TextEditingController();
    _preparationTime = TextEditingController();
    _instructions = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _recipeName.dispose();
    _ingredients.dispose();
    _description.dispose();
    _preparationTime.dispose();
    _instructions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              const TopBar(
                title: "Share your recipe",
              ),
              Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.only(
                  top: 120,
                ),
                height: MediaQuery.of(context).size.height / 1.2,
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
                          color: Colors.white,
                        ),
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 3,
                          dashPattern: const [10, 6],
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            child: pickedImage != null
                                ? Image.file(pickedImage!)
                                : IconButton(
                                    icon: const Icon(Icons.camera_alt_outlined),
                                    onPressed: () {
                                      pickImage(ImageSource.camera);
                                    },
                                    alignment: Alignment.center,
                                  ),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: Text("choose image from gallary?"),
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                          )),
                      Container(
                        child: TextFormField(
                          controller: _recipeName,
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                        ),
                      ),
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
                            decoration: const InputDecoration(
                                labelText: "Instructions"),
                            maxLength: 300),
                      ),
                      Container(
                        child: ElevatedButton(
                          child: const Text("Post"),
                          onPressed: () {
                            final food = <String, dynamic>{
                              "name": _recipeName.text,
                              "description": _description.text,
                              "ingredients": [_ingredients.text],
                              "preparation time": _preparationTime.text,
                              "instructions": _instructions.text,
                            };

                            FirebaseFirestore.instance
                                .collection("Recipes")
                                .doc()
                                .set(food)
                                .onError((e, _) =>
                                    print("Error writing document: $e"))
                                .catchError((error) =>
                                    print("Error adding food: $error"));
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
