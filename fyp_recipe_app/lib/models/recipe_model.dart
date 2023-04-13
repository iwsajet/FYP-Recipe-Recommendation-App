class RecipeModel {
  RecipeModel({
    this.recipePic,
    required this.id,
    required this.name,
    required this.recipeType,
    required this.ingredients,
    required this.description,
    required this.instruction,
    required this.preptime,
    required this.imageURL,
  });
  String? recipePic;
  String id;
  String name;
  String recipeType;
  String description;
  List<RecipeIngredientModel> ingredients;
  List<String> instruction;
  int preptime;
  String? imageURL;

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    print(map);
    return RecipeModel(
        id: map['_id'],
        recipePic: map['recipePic'],
        name: map['name'],
        recipeType: map['type'] ?? 'test',
        description: map['description'],
        ingredients: (map['ingredients'] as List<dynamic>)
            .map((e) => RecipeIngredientModel.fromMap(e))
            .toList(),
        instruction: (map['instructions'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        preptime: map['preptime'] ?? 0,
        imageURL: map['imageURL']);
  }
}

class RecipeIngredientModel {
  final String name;
  final String quantity;

  RecipeIngredientModel({required this.name, required this.quantity});

  factory RecipeIngredientModel.fromMap(Map<String, dynamic> map) {
    return RecipeIngredientModel(name: map['name'], quantity: map['quantity']);
  }
}
