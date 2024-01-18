// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/pages/details/kid_page.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../config/config_size.dart';
import '../model/model_recepies.dart';

class ComponentsAddNutrition extends StatelessWidget {
  final String id;
  final Recipe recipe;
  const ComponentsAddNutrition({
    required this.recipe,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    return Padding(
      padding: const EdgeInsets.only(left: paddingMin * 0.25),
      child: GestureDetector(
        onTap: () async {
          final DocumentReference nutritionReference =
              await firestoreService.addNutrition(
            recipe.label,
            recipe.image,
            recipe.energy,
            recipe.carbohydrates,
            recipe.fat,
            recipe.protein,
            recipe.water,
            recipe.fiber,
            recipe.totalSingleNutrition,
          );
          String nutritionId = nutritionReference.id;
          await firestoreService.addKidNutritionRelation(id, nutritionId);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KidPage(id: id),
            ),
          );
        },
        child: Container(
          height: paddingMin * 4,
          width: ConfigSize.blockSizeHorizontal! * 50,
          decoration: BoxDecoration(
            color: ConfigColor.darkBlue,
            borderRadius: BorderRadius.circular(paddingMin),
          ),
          child: Center(
            child: Text(
              "Tambahkan",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
