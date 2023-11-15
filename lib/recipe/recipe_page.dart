// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kids_nutrition_app/main.dart';
import 'package:kids_nutrition_app/recipe/model/model.dart';
import 'package:kids_nutrition_app/recipe/recipe_detail_page.dart';

class RecipePage extends StatefulWidget {
  final String kidDocId;

  RecipePage({
    required this.kidDocId,
    Key? key,
  }) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = 'nasi'; // Default search query

  @override
  void initState() {
    super.initState();
    // Initialize the search query based on user input
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  Future<List<Recipe>> getRecipe(String query) async {
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
            calories: recipe['calories'],
            ingredientLines: recipe['ingredientLines'],
            protein: nutrients['PROCNT']['quantity'],
            carbs: nutrients['CHOCDF']['quantity'],
            fat: nutrients['FAT']['quantity'],
          ),
        );
      }

      return recipes;
    } else {
      throw Exception('Failed to get recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search menu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (query) {
                  setState(
                    () {
                      searchQuery = query;
                    },
                  );
                },
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: getRecipe(searchQuery),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Recipe> recipes = snapshot.data as List<Recipe>;
              if (recipes.isEmpty) {
                return Center(
                  child: Text("No Data"),
                );
              }
              return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: paddingMin,
                      vertical: paddingMin / 3,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(
                              recipe: recipes[index],
                              kidDocId: widget.kidDocId,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              recipes[index].image,
                              width: 80, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            recipes[index].label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Calories: ${recipes[index].calories.toStringAsFixed(2)} kcal', // Display the protein quantity
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: paddingMin / 2,
                            horizontal: paddingMin,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
