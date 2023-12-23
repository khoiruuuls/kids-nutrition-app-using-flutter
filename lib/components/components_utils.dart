import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components/component_nutritions.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';
import 'package:kids_nutrition_app/model/model_nutritional_need.dart';

class ComponentsUtils extends StatelessWidget {
  final int age;
  final String gender;
  final double? kalori;
  final double? carbohydrates;
  final double? fiber;
  final double? water;
  final double? energy;
  final double? fat;
  final double? protein;

  const ComponentsUtils({
    super.key,
    required this.age,
    required this.gender,
    required this.kalori,
    required this.carbohydrates,
    required this.fiber,
    required this.water,
    required this.energy,
    required this.fat,
    required this.protein,
  });

  String calcNutrition(double? nutritionReal, nutritionSuggest) {
    if (nutritionSuggest != null) {
      if (nutritionSuggest == 0) {
        return "No data available";
      } else if (nutritionSuggest <= nutritionReal! - 100) {
        return "Gizi Kurang";
      } else if (nutritionSuggest <= nutritionReal + 100) {
        return "Gizi Normal";
      } else {
        return "Gizi Berlebih";
      }
    } else {
      return "No data avaliable.";
    }
  }

  @override
  Widget build(BuildContext context) {
    NutritionalNeed nutritionalNeed = NutritionalNeed();

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("nutritional_need")
          .doc(nutritionalNeed.nutrition_need(age, gender))
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ComponentsNutritions(
            text: calcNutrition(
              data['kalori'],
              kalori,
            ),
            carbohydrates: carbohydrates!.toStringAsFixed(2),
            fiber: fiber!.toStringAsFixed(2),
            water: water!.toStringAsFixed(2),
            energy: energy!.toStringAsFixed(2),
            fat: fat!.toStringAsFixed(2),
            protein: protein!.toStringAsFixed(2),
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
