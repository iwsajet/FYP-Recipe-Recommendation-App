import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'package:fyp_recipe_app/provider/login_provider.dart';
import 'package:fyp_recipe_app/provider/post_recipe_provider.dart';
import 'package:fyp_recipe_app/screens/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:http/http.dart' as http;
import '../custom_widget/ingredient_row.dart';
import '../models/ingredient_model.dart';
import '../network/api_response.dart';
import 'package:http_parser/http_parser.dart';

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
  late final TextEditingController preptimeController;

  late final PostRecipeProvider postRecipeProvider;
  XFile? pickedImage;
  int index = 0;
  List<String> _instructions = [];
  List<IngredientFormItemWidget> ingredientForms = List.empty(growable: true);

  Future pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;

      setState(
        () {
          pickedImage = photo;
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

    quantityController = TextEditingController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    preptimeController = TextEditingController();

    postRecipeProvider = context.read<PostRecipeProvider>();
    postRecipeProvider.addListener(postRecipeListener);
    super.initState();
  }

  void _postRecipe() async {
    if (recipeNameController.text.isEmpty ||
        recipeTypeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        preptimeController.text.isEmpty ||
        pickedImage == null) {
      // Show error messageif fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the required fields.'),
        ),
      );
      return;
    }

    log("testing....");

    final name = recipeNameController.text;
    final recipeType = recipeTypeController.text;
    final description = descriptionController.text;
    final preptime = preptimeController.text;
    final instruction = _instructions;

    if (_instructions.isNotEmpty && _formKey.currentState!.validate()) {
      List<Ingredient> ingredients =
          ingredientForms.map((e) => e.ingredientModel).toList();
      final formatedIngredient = ingredients
          .map((e) => {'name': e.name, 'quantity': e.quantity})
          .toList();
      try {
        final bytes = await pickedImage!.readAsBytes();

        final uri = Uri.parse('http://192.168.1.56:3000/postRecipe');
        final request = http.MultipartRequest('POST', uri);
        request.fields['userId'] =
            context.read<LoginProvider>().loginResponse.data!.id;
        request.fields['name'] = name;
        request.fields['type'] = recipeType;
        request.fields['preptime'] = preptime;
        request.fields['description'] = description;
        for (int i = 0; i < instruction.length; i++) {
          request.fields['instructions[$i]'] = instruction[i];
        }

        request.fields['ingredients'] = jsonEncode(formatedIngredient);
        request.files.add(http.MultipartFile.fromBytes('file', bytes,
            filename: pickedImage!.path.split('/').last.split('.').first,
            contentType: MediaType('image', pickedImage!.path.split('.').last)
            //contentType: MediaType.parse(pickedImage!.mimeType!),
            ));
        final response = await request.send();

        log(await response.stream.bytesToString());
        log(await response.statusCode.toString());

        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recipe added successfully.'),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recipe addition failed.'),
            ),
          );
        }
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  void postRecipeListener() {
    if (postRecipeProvider.postResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(postRecipeProvider.postResponse.error.toString())));
    } else if (postRecipeProvider.postResponse.status == Status.success) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  void dispose() {
    recipeNameController.dispose();
    recipeTypeController.dispose();
    descriptionController.dispose();
    preptimeController.dispose();

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
                              ? Image.file(File(pickedImage!.path))
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
                    IconButton(
                        onPressed: () {
                          onAdd();
                        },
                        icon: const Icon(Icons.add)),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ingredientForms.length,
                        itemBuilder: (_, index) {
                          return ingredientForms[index];
                        }),
                    TextFormField(
                      controller: preptimeController,
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
                        _postRecipe();
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
