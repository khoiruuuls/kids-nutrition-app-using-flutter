// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element, avoid_print, void_checks, unnecessary_null_comparison, sort_child_properties_last, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import '../../services/firestore.dart';
import 'component_nutritions.dart';

class KidTarget extends StatefulWidget {
  final String id;
  const KidTarget({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<KidTarget> createState() => _KidTargetState();
}

class _KidTargetState extends State<KidTarget> {
  FirestoreService firestoreService = FirestoreService();
  double? totalKalori,
      totalProtein,
      totalLemak,
      totalKarbohidrat,
      totalSerat,
      totalAir,
      totalAll;
  double? inPercentKalori,
      inPercentProtein,
      inPercentLemak,
      inPercentKarbohidrat,
      inPercentSerat,
      inPercentAir;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreService.getNutritionForKid(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Future<double>> kaloriFutures = [];
          List<Future<double>> proteinFutures = [];
          List<Future<double>> lemakFutures = [];
          List<Future<double>> karbohidratFutures = [];
          List<Future<double>> seratFutures = [];
          List<Future<double>> airFutures = [];

          snapshot.data!.docs.forEach(
            (document) {
              final data = document.data() as Map<String, dynamic>;
              final nutritionId = data['nutritionId'] ?? '';

              Future<double> getNutritionData(String field) async {
                final value =
                    await firestoreService.getNutritionById(nutritionId);
                final nutritionData = value.data() as Map<String, dynamic>;
                return (nutritionData[field] as double?) ?? 0;
              }

              kaloriFutures.add(getNutritionData('kalori'));
              seratFutures.add(getNutritionData('fiber'));
              airFutures.add(getNutritionData('water'));
              proteinFutures.add(getNutritionData('protein'));
              lemakFutures.add(getNutritionData('lemak'));
              karbohidratFutures.add(getNutritionData('karbohidrat'));
            },
          );

          // Wait for all FutureBuilder widgets to complete before calculating totals
          return FutureBuilder(
            future: Future.wait([
              ...kaloriFutures,
              ...proteinFutures,
              ...lemakFutures,
              ...karbohidratFutures,
              ...seratFutures,
              ...airFutures,
            ]),
            builder: (context, futuresSnapshot) {
              if (futuresSnapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...'); // Show a loading indicator
              }

              // Separate the results for kalori, protein, lemak, and karbohidrat
              List<double?> kaloriList =
                  futuresSnapshot.data!.sublist(0, kaloriFutures.length);
              List<double?> proteinList = futuresSnapshot.data!.sublist(
                  kaloriFutures.length,
                  kaloriFutures.length + proteinFutures.length);
              List<double?> lemakList = futuresSnapshot.data!.sublist(
                  kaloriFutures.length + proteinFutures.length,
                  kaloriFutures.length +
                      proteinFutures.length +
                      lemakFutures.length);
              List<double?> karbohidratList = futuresSnapshot.data!.sublist(
                  kaloriFutures.length +
                      proteinFutures.length +
                      lemakFutures.length);
              List<double?> seratList = futuresSnapshot.data!.sublist(
                  kaloriFutures.length +
                      proteinFutures.length +
                      lemakFutures.length +
                      seratFutures.length);
              List<double?> airList = futuresSnapshot.data!.sublist(
                  kaloriFutures.length +
                      proteinFutures.length +
                      lemakFutures.length +
                      seratFutures.length +
                      airFutures.length);

              // Calculate the totals
              totalKalori = kaloriList.fold(
                  0, (previous, current) => previous! + current!);
              totalProtein = proteinList.fold(
                  0, (previous, current) => previous! + current!);
              totalLemak = lemakList.fold(
                  0, (previous, current) => previous! + current!);
              totalKarbohidrat = karbohidratList.fold(
                  0, (previous, current) => previous! + current!);
              totalSerat = seratList.fold(
                  0, (previous, current) => previous! + current!);
              totalAir =
                  airList.fold(0, (previous, current) => previous! + current!);

              totalAll = totalKalori! +
                  totalProtein! +
                  totalLemak! +
                  totalKarbohidrat! +
                  totalSerat! +
                  totalAir!;

              inPercentKalori = totalKalori! * 100 / totalAll!;
              inPercentProtein = totalProtein! * 100 / totalAll!;
              inPercentLemak = totalLemak! * 100 / totalAll!;
              inPercentKarbohidrat = totalKarbohidrat! * 100 / totalAll!;
              inPercentSerat = totalSerat! * 100 / totalAll!;
              inPercentAir = totalAir! * 100 / totalAll!;

              // Display the totals
              return ComponentsNutritions(
                carbohydrates: (inPercentKarbohidrat != null &&
                        !inPercentKarbohidrat!.isNaN)
                    ? "${inPercentKarbohidrat!.toStringAsFixed(2)} %"
                    : "0.00 %",
                fiber: (inPercentSerat != null && !inPercentSerat!.isNaN)
                    ? "${inPercentSerat!.toStringAsFixed(2)} %"
                    : "0.00 %",
                water: (inPercentAir != null && !inPercentAir!.isNaN)
                    ? "${inPercentAir!.toStringAsFixed(2)} %"
                    : "0.00 %",
                energy: (inPercentKalori != null && !inPercentKalori!.isNaN)
                    ? "${inPercentKalori!.toStringAsFixed(2)} %"
                    : "0.00 %",
                fat: (inPercentLemak != null && !inPercentLemak!.isNaN)
                    ? "${inPercentLemak!.toStringAsFixed(2)} %"
                    : "0.00 %",
                protein: (inPercentProtein != null && !inPercentProtein!.isNaN)
                    ? "${inPercentProtein!.toStringAsFixed(2)} %"
                    : "0.00 %",
              );
            },
          );
        } else {
          return Text("Tidak ada data");
        }
      },
    );
  }
}
