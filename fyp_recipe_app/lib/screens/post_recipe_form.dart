import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/add_instructions.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'package:fyp_recipe_app/models/post_model.dart';
import 'package:fyp_recipe_app/provider/post_recipe_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';

import '../custom_widget/add_ingredient.dart';
import '../models/ingredient_model.dart';

class PostRecipe extends StatefulWidget {
  const PostRecipe({super.key});

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {
  late final TextEditingController recipeNameController;
  late final TextEditingController recipeTypeController;
  late final TextEditingController ingredientsController;
  late final TextEditingController descriptionController;
  late final TextEditingController preparationTimeController;
  late final TextEditingController instructionsController;
  late final PostRecipeProvider postRecipeProvider;

  final List<Ingredient> _ingredientsList = [];
 
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
    recipeNameController = TextEditingController();
    recipeTypeController = TextEditingController();
    ingredientsController = TextEditingController();
    descriptionController = TextEditingController();
    preparationTimeController = TextEditingController();
    instructionsController = TextEditingController();
    _ingredientsList.add(Ingredient(quantity: '', name: ''));
    //_instructionList.add(String(instruction: ''));
    postRecipeProvider = context.read<PostRecipeProvider>();
    postRecipeProvider.addListener(postRecipeListener);
    super.initState();
  }

  void postRecipeListener() {}
  @override
  void dispose() {
    recipeNameController.dispose();
    recipeTypeController.dispose();
    ingredientsController.dispose();
    descriptionController.dispose();
    preparationTimeController.dispose();
    instructionsController.dispose();
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
                          child: SizedBox(
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
                            child: const Text("choose image from gallary?"),
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                          )),
                      Container(
                        child: TextFormField(
                          controller: recipeNameController,
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: recipeTypeController,
                          decoration: const InputDecoration(
                            labelText: "Recipe Type",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                            controller: descriptionController,
                            decoration:
                                const InputDecoration(labelText: "Description"),
                            maxLength: 300),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: ListView.builder(
                            // shrinkWrap: true,
                            //  physics: const NeverScrollableScrollPhysics(),
                            itemCount: _ingredientsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return IngredientRow(
                                quantityController: TextEditingController(
                                    text: _ingredientsList[index].quantity),
                                nameController: TextEditingController(
                                    text: _ingredientsList[index].name),
                                onAddPressed: () {
                                  setState(() {
                                    _ingredientsList.add(
                                        Ingredient(quantity: '', name: ''));
                                  });
                                },
                                onRemovePressed: () {
                                  setState(() {
                                    _ingredientsList.removeAt(index);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: preparationTimeController,
                          decoration: const InputDecoration(
                              labelText: "Preparation time",
                              hintText: "Rough estimate on preparation time"),
                        ),
                      ),
                      Container(
                        // child: TextFormField(
                        //     controller: instructionsController,
                        //     decoration: const InputDecoration(
                        //         labelText: "Instructions"),
                        //     maxLength: 300),
                        FlutterInputChips()
                      ),
                      
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 50)),
                          child: const Text("Post"),
                          onPressed: () {},
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

class Buttonwidget extends StatelessWidget {
  const Buttonwidget({
    super.key,
    required this.recipeNameController,
    required this.descriptionController,
    required this.ingredientsController,
    required this.instructionController,
    required this.preparationTimeController,
  });
  final TextEditingController recipeNameController;
  final TextEditingController descriptionController;
  final TextEditingController ingredientsController;
  final TextEditingController instructionController;
  final TextEditingController preparationTimeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: ElevatedButton(
        //   onPressed: () {RecipeModel recipe = RecipeModel(name: recipeNameController.text, ingredients: ingredientsController.text, instruction: instructionController.text, preptime: preparationTimeController.text,);},
        //   child: const Text("Post"),
        // )
        );
  }
}
