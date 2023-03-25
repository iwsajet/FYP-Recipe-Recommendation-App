import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'package:fyp_recipe_app/provider/post_recipe_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';

import '../custom_widget/add_ingredient.dart';
import '../models/ingredient_model.dart';
import '../network/api_response.dart';

class PostRecipe extends StatefulWidget {
  const PostRecipe({super.key});

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {
  late final TextEditingController recipeNameController;
  late final TextEditingController recipeTypeController;
  late final TextEditingController quantityController;
  late final TextEditingController nameController;
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

  void _addIngredient() {
    setState(() {
      _ingredientsList.add(Ingredient(quantity: '', name: ''));
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientsList.removeAt(index);
    });
  }

  @override
  void initState() {
    recipeNameController = TextEditingController();
    recipeTypeController = TextEditingController();
    //ingredientsController = TextEditingController();
    quantityController = TextEditingController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    preparationTimeController = TextEditingController();
    instructionsController = TextEditingController();
    _ingredientsList.add(Ingredient(quantity: '', name: ''));
    postRecipeProvider = context.read<PostRecipeProvider>();
    postRecipeProvider.addListener(postRecipeListener);

    super.initState();
  }

  void postRecipeListener() {
    if (postRecipeProvider.postResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(postRecipeProvider.postResponse.error.toString())));
    } else if (postRecipeProvider.postResponse.status == Status.success) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    recipeNameController.dispose();
    recipeTypeController.dispose();
    //ingredientsController.dispose();
    descriptionController.dispose();
    preparationTimeController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              child: SingleChildScrollView(
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
                    TextFormField(
                      controller: recipeNameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                      ),
                    ),
                    TextFormField(
                      controller: recipeTypeController,
                      decoration: const InputDecoration(
                        labelText: "Recipe Type",
                      ),
                    ),
                    TextFormField(
                        controller: descriptionController,
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        maxLength: 300),
                   
                    TextFormField(
                      controller: preparationTimeController,
                      decoration: const InputDecoration(
                          labelText: "Preparation time",
                          hintText: "Rough estimate on preparation time"),
                    ),
                    FlutterInputChips(
                      initialValue: const [],
                      maxChips: 20,
                      onChanged: (v) {
                        setState(() {
                          v;
                        });
                      },
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter instructions here",
                      ),
                      chipTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      chipSpacing: 8,
                      chipDeleteIconColor: Colors.grey,
                      chipBackgroundColor: Colors.white,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 50)),
                      child: const Text("Post"),
                      onPressed: () {
                        for (int i = 0; i < _ingredientsList.length; i++) {
                          print(_ingredientsList[i].name);
                        }
                        //context.read<PostRecipeProvider>().postRecipe(recipePic: pickedImage, name: recipeNameController.text, type: recipeTypeController.text, description: descriptionController.text, ingredients: ingredientsController.text, preptime: preparationTimeController.text, instruction: instructionsController.text,),
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}