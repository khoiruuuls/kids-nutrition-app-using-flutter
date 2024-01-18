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
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return ComponentsNutritions(
            text: "Nutrisi yang dibutuhkan",
            carbohydrates: data['karbohidrat'].toString(),
            fiber: data['serat'].toString(),
            water: data['air'].toString(),
            energy: data['kalori'].toString(),
            fat: data['lemak'].toString(),
            protein: data['protein'].toString(),
            isNote: true,
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
