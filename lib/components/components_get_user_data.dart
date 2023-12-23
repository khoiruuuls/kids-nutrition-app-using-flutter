import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';

import '../model/model_age_counter.dart';
import 'components_utils.dart';

class ComponentsGetUserData extends StatelessWidget {
  final String id;
  final double? kalori;
  final double? carbohydrates;
  final double? fiber;
  final double? water;
  final double? energy;
  final double? fat;
  final double? protein;

  const ComponentsGetUserData({
    Key? key,
    required this.id,
    required this.kalori,
    required this.carbohydrates,
    required this.fiber,
    required this.water,
    required this.energy,
    required this.fat,
    required this.protein,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AgeCounter ageCounter = AgeCounter();
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!;
          // Now you can use the retrieved data to build your UI
          return ComponentsUtils(
            carbohydrates: carbohydrates,
            fiber: fiber,
            water: water,
            energy: energy,
            fat: fat,
            protein: protein,
            kalori: kalori,
            age: ageCounter.calculateAge(data['dateBirth']),
            gender: data['gender'],
          );
        } else {
          // Handle the case where no data is available
          return const ComponentsNoData();
        }
      },
    );
  }
}
