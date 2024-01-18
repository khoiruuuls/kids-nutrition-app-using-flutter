import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components/component_nutritions.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';
import 'package:kids_nutrition_app/config/config_size.dart';
import 'package:kids_nutrition_app/model/model_nutritional_need.dart';
import 'package:line_icons/line_icon.dart';

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

  /* ------------------------------------------------------------------------------------ 
  contoh kasus perhitungan nilai kalori 
  untuk Fauzan anak laki laki dengan umur 10 - 12

  kalori yang dibutukan adalah 2000 (nutritionSuggest) 
  
  Fauzan telah mengkonsumsi makanan dengan total kalori 1705 (nutritionReal)
  Fauzan telah mengkonsumsi makanan dengan total karbo 415 (nutritionReal)
  
  dengan toleransi 1.5 kali dari nutritionSuggest
  yang artinya 1.5 * 2000 (nutritionSuggest)
            =  3000 (kalori)

  dengan toleransi 1.5 kali dari nutritionSuggest
  yang artinya 1.5 * 1850 (nutritionSuggest)
            =  2775 (air)

  dengan toleransi 1.5 kali dari nutritionSuggest
  yang artinya 1.5 * 300 (nutritionSuggest)
            =  450 (karbohidrat)


  ------------------------------------------------------------------------------------- */

  iconNutrition(double? nutritionSuggest, double? nutritionReal) {
    if (nutritionReal == 0) {
      return const LineIcon.arrowDown(
        color: Colors.white,
        size: 13,
      );
    } else if (nutritionReal! <= nutritionSuggest! * 1.5) {
      return const LineIcon.thumbsUp(
        color: Colors.white,
        size: 13,
      );
    } else {
      return const LineIcon.arrowUp(
        color: Colors.white,
        size: 13,
      );
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

          final formattedTime =
              DateFormat('dd MMMM y', 'id_ID').format(DateTime.now());

          return ComponentsNutritions(
            text: "Nutrisi ${formattedTime}",
            carbohydrates: carbohydrates!.toStringAsFixed(2),
            fiber: fiber!.toStringAsFixed(2),
            water: water!.toStringAsFixed(2),
            energy: energy!.toStringAsFixed(2),
            fat: fat!.toStringAsFixed(2),
            protein: protein!.toStringAsFixed(2),
            iconCarbohydrates:
                iconNutrition(data['karbohidrat'], carbohydrates ?? 0.0),
            iconFiber: iconNutrition(data['serat'], fiber ?? 0.0),
            iconWater: iconNutrition(data['air'], water ?? 0.0),
            iconEnergy: iconNutrition(data['kalori'], kalori ?? 0.0),
            iconFat: iconNutrition(data['lemak'], fat ?? 0.0),
            iconProtein: iconNutrition(data['protein'], protein ?? 0.0),
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
