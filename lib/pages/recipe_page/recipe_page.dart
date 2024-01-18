// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kids_nutrition_app/components/components_back.dart';
import 'package:kids_nutrition_app/components/components_category_recomendation.dart';
import 'package:kids_nutrition_app/model/model_recepies.dart';
import 'package:kids_nutrition_app/pages/recipe_page/recipe_detail_page.dart';
import 'package:line_icons/line_icon.dart';

import '../../components/list_helper/component_list_helper.dart';
import '../../config/config_size.dart';

class RecipePage extends StatefulWidget {
  final String id;

  RecipePage({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  TextEditingController searchController = TextEditingController();
  ComponentsListHelper componentsListHelper = ComponentsListHelper();
  List<Recipe> recipes = [];
  int selectedFoodIndex = 0;
  String searchQuery = "";
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();

    //
    searchQuery = componentsListHelper.food[selectedFoodIndex];

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        if (!isFirstLoad) {
          loadRecipes();
        }
      });
    });

    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      if (searchQuery.isNotEmpty) {
        List<Recipe> result = await getRecipe(searchQuery);
        setState(() {
          recipes = result;
        });
      }
    } catch (e) {
      print('Error loading recipes: $e');
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ComponentsBack(textTitle: "Choose meal"),
            Padding(
              padding: const EdgeInsets.only(
                left: paddingMin,
                right: paddingMin,
                bottom: paddingMin,
                top: paddingMin / 2,
              ),
              child: TextField(
                style: GoogleFonts.poppins(),
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(paddingMin),
                  prefixIcon: IconTheme(
                    data: IconThemeData(color: Colors.grey.shade300),
                    child: LineIcon.search(),
                  ),
                  hintText: "Search Menu",
                  border: kInputBorder,
                  errorBorder: kInputBorder,
                  focusedBorder: kInputBorder,
                ),
                onSubmitted: (query) {
                  loadRecipes();
                },
              ),
            ),
            ComponentsCategoryRecomendation(
              onCategorySelected: (selectedFood) {
                setState(() {
                  searchQuery = selectedFood;
                  loadRecipes();
                });
              },
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  MasonryGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 25,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    padding: EdgeInsets.symmetric(horizontal: paddingMin),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(
                                recipe: recipes[index],
                                id: widget.id,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: index == 1 ? 280 : 240,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(paddingMin),
                                child: Container(
                                  child: Image.network(
                                    recipes[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Text(
                                      recipes[index].label,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
