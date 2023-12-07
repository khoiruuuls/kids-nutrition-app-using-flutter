// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components/component_nutritions.dart';
import 'package:kids_nutrition_app/components/components_add_nutrition.dart';
import 'package:kids_nutrition_app/components/components_back.dart';
import 'package:kids_nutrition_app/components/components_counter.dart';
import 'package:kids_nutrition_app/model/model_recepies.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../../config/config_size.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  final String id;

  RecipeDetailPage({
    required this.id,
    required this.recipe,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ConfigSize.blockSizeVertical! * 45,
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                widget.recipe.image,
                                height: ConfigSize.blockSizeVertical! * 50,
                                width: double.infinity, // Use the full width
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 35,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(paddingMin * 3),
                                    topRight: Radius.circular(paddingMin * 3),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: paddingMin * 3 / 2),
                                child: Text(
                                  widget.recipe.label,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: paddingMin * 3 / 2),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: paddingMin,
                                ),
                                child: ComponentsNutritions(
                                  carbohydrates: widget.recipe.carbohydrates
                                      .toStringAsFixed(2),
                                  fiber: widget.recipe.fiber.toStringAsFixed(2),
                                  water: widget.recipe.water.toStringAsFixed(2),
                                  energy:
                                      widget.recipe.energy.toStringAsFixed(2),
                                  fat: widget.recipe.fat.toStringAsFixed(2),
                                  protein:
                                      widget.recipe.protein.toStringAsFixed(2),
                                ),
                              ),
                              SizedBox(height: paddingMin),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: paddingMin),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(paddingMin),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ComponentsAddNutrition(
                                        id: widget.id,
                                        recipe: widget.recipe,
                                      ),
                                      ComponentsCounter(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: paddingMin),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  ComponentsBack(
                    textTitle: widget.recipe.label,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
