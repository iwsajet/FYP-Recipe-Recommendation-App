import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'package:fyp_recipe_app/provider/post_recipe_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';

import '../custom_widget/add_ingredient.dart';
import '../custom_widget/ingredient_row.dart';
import '../models/ingredient_model.dart';
import '../network/api_response.dart';

class PostRecipe extends StatefulWidget {
  const PostRecipe({super.key});

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController recipeNameController;
  late final TextEditingController recipeTypeController;
  late final TextEditingController quantityController;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController preparationTimeController;
  late final TextEditingController instructionsController;
  late final PostRecipeProvider postRecipeProvider;
  int index = 0;
  List<String> _instructions = [];
  List<IngredientFormItemWidget> ingredientForms = List.empty(growable: true);
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

  onRemove(Ingredient ingredient) {
    setState(() {
      int index = ingredientForms
          .indexWhere((element) => element.ingredientModel.id == ingredient.id);

      ingredientForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      Ingredient _ingredientModel =
          Ingredient(id: ingredientForms.length, name: '', quantity: '');
      ingredientForms.add(IngredientFormItemWidget(
        index: ingredientForms.length,
        ingredientModel: _ingredientModel,
        onRemove: () => onRemove(_ingredientModel),
      ));
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
              key: _formKey,
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
                    //Ingredient row here
                    // IngredientRow(quantityController: quantityController, nameController: nameController, onAddPressed: _addIngredient, onRemovePressed: _removeIngredient(index)),

                    IconButton(
                        onPressed: () {
                          onAdd();
                        },
                        icon: Icon(Icons.add)),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ingredientForms.length,
                        itemBuilder: (_, index) {
                          return ingredientForms[index];
                        }),
                    TextFormField(
                      controller: preparationTimeController,
                      decoration: const InputDecoration(
                          labelText: "Preparation time",
                          hintText:
                              "Preparation time will be counted in minutes. eg 40"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FlutterInputChips(
                      initialValue: const [],
                      maxChips: 20,
                      onChanged: (v) {
                        setState(() {
                          _instructions = v;
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
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 50),
                      ),
                      child: const Text("Post"),
                      onPressed: () {
                        bool allValid = true;
                        for (var element in ingredientForms) {
                          allValid = (allValid && element.isValidated());
                        }

                        if (allValid &&
                            _instructions.isNotEmpty &&
                            _formKey.currentState!.validate()) {
                          List<Ingredient> ingredients = ingredientForms
                              .map((e) => e.ingredientModel)
                              .toList();

                          print("ingredients $ingredients");

                          context.read<PostRecipeProvider>().postRecipe(
                                recipePic: pickedImage,
                                name: recipeNameController.text,
                                type: recipeTypeController.text,
                                description: descriptionController.text,
                                ingredients: ingredients
                                    .map((e) => {
                                          'name': e.name,
                                          'quantity': e.quantity
                                        })
                                    .toList(),
                                preptime: preparationTimeController.text,
                                instruction: _instructions,
                              );
                        } else {
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(const SnackBar(
                                content: Text('Some values are not filled')));
                        }
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
