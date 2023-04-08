class RecipeTypeModel {
  final String title;
  final String imageurl;
  RecipeTypeModel({required this.title, required this.imageurl});
}

List<RecipeTypeModel> recipeTypes = [
  RecipeTypeModel(title: 'Breakfast', imageurl: 'assets/icons/breakfast.png'),
  RecipeTypeModel(title: 'Lunch', imageurl: 'assets/icons/meal.png'),
  RecipeTypeModel(title: 'Dinner', imageurl: 'assets/icons/dinner.png'),
  RecipeTypeModel(title: 'Baking', imageurl: 'assets/icons/bake.png'),
  RecipeTypeModel(title: 'Soup', imageurl: 'assets/icons/hot-soup.png'),
  RecipeTypeModel(title: 'Diet', imageurl: 'assets/icons/diet.png')
];
