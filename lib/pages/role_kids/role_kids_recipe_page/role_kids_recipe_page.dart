// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_list_recipe.dart';
import 'package:kids_nutrition_app/model/model_recepies.dart';

import '../../../components/components_back.dart';
import '../../../components/components_category_recomendation.dart';
import '../../../components/components_search.dart';
import '../../../components/list_helper/component_list_helper.dart';
import '../../../config/config_void.dart';
import '../../../services/recipe_service.dart';
import 'role_kids_recipe_detail.dart';

class RoleKidsRecipePage extends StatefulWidget {
  final String id;

  RoleKidsRecipePage({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _RoleKidsRecipePageState createState() => _RoleKidsRecipePageState();
}

class _RoleKidsRecipePageState extends State<RoleKidsRecipePage> {
  TextEditingController searchController = TextEditingController();
  ComponentsListHelper componentsListHelper = ComponentsListHelper();

  List<Recipe> recipes = [];
  int selectedFoodIndex = 0;
  String searchQuery = "";
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
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
        List<Recipe> result = await RecipeService.getRecipes(searchQuery);
        setState(() {
          recipes = result;
        });
      }
    } catch (e) {
      print('Error loading recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ComponentsBack(textTitle: "Choose meal single"),
            ComponentsSearch(
              controller: searchController,
              onSubmitted: (query) {
                loadRecipes();
              },
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
              child: ComponentsListRecipe(
                itemCount: recipes.length,
                onTap: (index) {
                  navigateToPage(
                    context,
                    RoleKidsRecipeDetail(id: widget.id, recipe: recipes[index]),
                  );
                },
                image: (index) => recipes[index].image,
                label: (index) => recipes[index].label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
