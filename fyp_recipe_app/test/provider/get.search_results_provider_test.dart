import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_recipe_app/models/recipe_model.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:fyp_recipe_app/provider/get.search_results_provider.dart';
import 'package:fyp_recipe_app/services/search_service.dart';

class MockSearchService implements SearchService {
  @override
  Future<List<RecipeModel>> searchRecipe(
      {required List<String> ingredientNames}) async {
    // Mock of the search response
    await Future.delayed(const Duration(seconds: 1));

    if (ingredientNames.contains('ingredient1') &&
        ingredientNames.contains('ingredient2')) {
      return [
        RecipeModel(
          id: '123',
          name: 'Test Recipe',
          recipeType: 'Test Type',
          description: 'Test Description',
          ingredients: [
            RecipeIngredientModel(name: 'Ingredient1', quantity: '1'),
            RecipeIngredientModel(name: 'Ingredient2', quantity: '2'),
          ],
          instruction: ['Instruction 1', 'Instruction 2'],
          preptime: 10,
          imageURL: 'https://testimageurl.com',
        )
      ];
    }
    throw Exception("Error");
  }
}

void main() {
  group('SearchProvider', () {
    late GetSearchProvider searchProvider;
    late MockSearchService mockSearchService;

    setUp(() {
      mockSearchService = MockSearchService();
      searchProvider = GetSearchProvider(searchService: mockSearchService);
    });

    test(
        'searchRecipe() should get getSearchResponse as ApSiResponse.success with RecipeModel data on successful search',
        () async {
      // Arrange
      const ingredientNames = ['ingredient1', 'ingredient2'];

      // Act
      await searchProvider.searchRecipe(ingredientNames: ingredientNames);

      // Assert
      expect(searchProvider.getSearchResponse.status, equals(Status.success));
      expect(searchProvider.getSearchResponse.data, isA<List<RecipeModel>>());
      expect(searchProvider.getSearchResponse.data?.length, equals(1));
      expect(searchProvider.getSearchResponse.data?[0].name,
          equals('Test Recipe'));
      expect(searchProvider.getSearchResponse.error, isNull);
    });

    test(
        'searchRecipe() should get getSearchResponse as ApiResponse.error on failed search',
        () async {
      // Arrange
      const ingredientNames = ['ingredient1', 'ingredient3'];

      // Act
      await searchProvider.searchRecipe(ingredientNames: ingredientNames);

      // Assert
      expect(searchProvider.getSearchResponse.status, equals(Status.error));
      expect(searchProvider.getSearchResponse.data, isNull);
      expect(searchProvider.getSearchResponse.error, isNotNull);
    });
  });
}
