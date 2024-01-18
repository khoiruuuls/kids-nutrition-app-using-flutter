// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/components/component_nutritions.dart';
import '../../../components/components_back.dart';
import '../../../components/components_counter.dart';
import '../../../config/config_size.dart';
import '../../../model/model_recepies.dart';
import '../../../services/firestore.dart';
import '../role_kids_components/role_kids_components_add_nutrition.dart';

class RoleKidsRecipeDetail extends StatefulWidget {
  final Recipe recipe;
  final String id;

  RoleKidsRecipeDetail({
    required this.id,
    required this.recipe,
  });

  @override
  State<RoleKidsRecipeDetail> createState() => _RoleKidsRecipeDetailState();
}

class _RoleKidsRecipeDetailState extends State<RoleKidsRecipeDetail> {
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingMin),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: paddingMin),
                                  child: Text(
                                    widget.recipe.label,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: paddingMin * 1.5),
                                ComponentsNutritions(
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
                                SizedBox(height: paddingMin * 2),
                                Container(
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: paddingMin),
                              ],
                            ),
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
