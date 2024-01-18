// recipe_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kids_nutrition_app/model/model_recepies.dart';

class RecipeService {
  static Future<List<Recipe>> getRecipes(String query) async {
    try {
      var response = await http.get(
        Uri.https(
          'api.edamam.com',
          '/search',
          {
            'q': query,
            'app_id': '00115865',
            'app_key': 'd1eaf99f7b68e66bee098d9bbae0ada0',
          },
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Recipe> recipes = [];

        for (var hit in jsonData['hits']) {
          var recipe = hit['recipe'];
          var nutrients = recipe['totalNutrients'];
          recipes.add(
            Recipe(
              image: recipe['image'],
              label: recipe['label'],
              energy: recipe['calories'],
              ingredientLines: recipe['ingredientLines'],
              protein: nutrients['PROCNT']['quantity'],
              carbohydrates: nutrients['CHOCDF']['quantity'],
              fat: nutrients['FAT']['quantity'],
              water: nutrients['WATER']['quantity'],
              fiber: nutrients['FIBTG']['quantity'],
              totalSingleNutrition: recipe['calories'] +
                  nutrients['PROCNT']['quantity'] +
                  nutrients['CHOCDF']['quantity'] +
                  nutrients['FAT']['quantity'] +
                  nutrients['WATER']['quantity'] +
                  nutrients['FIBTG']['quantity'],
            ),
          );
        }

        return recipes;
      } else {
        throw Exception('Failed to get recipes');
      }
    } catch (e) {
      throw Exception('Error loading recipes: $e');
    }
  }
}
