// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components/component_nutritions.dart';

import '../../model/model_nutritional_need.dart';
import '../components_no_data.dart';

class KidCompare extends StatelessWidget {
  final int age;
  final String gender;
  const KidCompare({
    required this.age,
    required this.gender,
    super.key,
  });

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
          // Access the document data
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // Assuming total value is stored in the 'total' field
          // double total = data['karbohidrat'] +
          //         data['serat'] +
          //         data['air'] +
          //         data['kalori'] +
          //         data['lemak'] +
          //         data['protein'] ??
          //     0.0;

          // Calculate percentages
          // double inPercentKarbohidrat =
          //     (data['karbohidrat'] as double?)! / total * 100;
          // double inPercentSerat = (data['serat'] as double?)! / total * 100;
          // double inPercentAir = (data['air'] as double?)! / total * 100;
          // double inPercentKalori = (data['kalori'] as double?)! / total * 100;
          // double inPercentLemak = (data['lemak'] as double?)! / total * 100;
          // double inPercentProtein = (data['protein'] as double?)! / total * 100;

          // return ComponentsNutritions(
          //   carbohydrates: inPercentKarbohidrat.toStringAsFixed(2) + '%',
          //   fiber: inPercentSerat.toStringAsFixed(2) + '%',
          //   water: inPercentAir.toStringAsFixed(2) + '%',
          //   energy: inPercentKalori.toStringAsFixed(2) + '%',
          //   fat: inPercentLemak.toStringAsFixed(2) + '%',
          //   protein: inPercentProtein.toStringAsFixed(2) + '%',
          // );
          // return ComponentsNutritions(
          //   carbohydrates: inPercentKarbohidrat.toStringAsFixed(2) + '%',
          //   fiber: inPercentSerat.toStringAsFixed(2) + '%',
          //   water: inPercentAir.toStringAsFixed(2) + '%',
          //   energy: inPercentKalori.toStringAsFixed(2) + '%',
          //   fat: inPercentLemak.toStringAsFixed(2) + '%',
          //   protein: inPercentProtein.toStringAsFixed(2) + '%',
          // );
          return ComponentsNutritions(
            text: "Require Nutrition by age and gender",
            carbohydrates: data['karbohidrat'].toString(),
            fiber: data['serat'].toString(),
            water: data['air'].toString(),
            energy: data['kalori'].toString(),
            fat: data['lemak'].toString(),
            protein: data['protein'].toString(),
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
