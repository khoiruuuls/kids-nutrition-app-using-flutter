// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element, avoid_print, void_checks, unnecessary_null_comparison, sort_child_properties_last, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_chart.dart';
import 'package:kids_nutrition_app/components/components_get_user_data.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';
import '../../config/config_size.dart';
import '../../services/firestore.dart';

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

  Map<String, double> calculateNutrientSum(
      List<Map<String, dynamic>> nutrients) {
    double sumKalori = 0;
    double sumProtein = 0;
    double sumLemak = 0;
    double sumKarbohidrat = 0;
    double sumSerat = 0;
    double sumAir = 0;

    for (var nutrient in nutrients) {
      sumKalori += nutrient['kalori'] ?? 0;
      sumProtein += nutrient['protein'] ?? 0;
      sumLemak += nutrient['lemak'] ?? 0;
      sumKarbohidrat += nutrient['karbohidrat'] ?? 0;
      sumSerat += nutrient['fiber'] ?? 0;
      sumAir += nutrient['water'] ?? 0;
    }

    return {
      'kalori': sumKalori,
      'protein': sumProtein,
      'lemak': sumLemak,
      'karbohidrat': sumKarbohidrat,
      'serat': sumSerat,
      'air': sumAir,
    };
  }

  @override
  Widget build(BuildContext context) {
    final double hello = 0;
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
                    lemakFutures.length,
                kaloriFutures.length +
                    proteinFutures.length +
                    lemakFutures.length +
                    karbohidratFutures.length,
              );
              List<double?> seratList = futuresSnapshot.data!.sublist(
                kaloriFutures.length +
                    proteinFutures.length +
                    lemakFutures.length +
                    karbohidratFutures.length,
                kaloriFutures.length +
                    proteinFutures.length +
                    lemakFutures.length +
                    karbohidratFutures.length +
                    seratFutures.length,
              );

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

              print(kaloriList);
              List<Map<String, dynamic>> kaloriWithTimestamp = [];
              for (int i = 0; i < kaloriList.length; i++) {
                final timestamp = snapshot.data!.docs[i][
                    'timestamp']; // Adjust this according to your data structure
                kaloriWithTimestamp
                    .add({'timestamp': timestamp, 'kalori': kaloriList[i]});
              }

              Map<String, double> nutrientSum =
                  calculateNutrientSum(kaloriWithTimestamp);

              // Access the sum for each nutrient
              double sumKalori = nutrientSum['kalori'] ?? 0;
              double sumProtein = nutrientSum['protein'] ?? 0;
              double sumLemak = nutrientSum['lemak'] ?? 0;
              double sumKarbohidrat = nutrientSum['karbohidrat'] ?? 0;
              double sumSerat = nutrientSum['serat'] ?? 0;
              double sumAir = nutrientSum['air'] ?? 0;

              kaloriWithTimestamp
                  .sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

              // Display the totals
              return Column(
                children: [
                  ComponentsGetUserData(
                    id: widget.id,
                    carbohydrates: totalKarbohidrat,
                    fiber: totalSerat,
                    water: totalAir,
                    energy: totalKalori,
                    fat: totalLemak,
                    protein: totalProtein,
                    kalori: totalKalori,
                  ),
                  SizedBox(height: paddingMin * 1.5),
                  ComponentsChart(
                    dayOne: (kaloriWithTimestamp.isNotEmpty)
                        ? (kaloriWithTimestamp[0]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                    dayTwo: (kaloriWithTimestamp.length > 1)
                        ? (kaloriWithTimestamp[1]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                    dayThree: (kaloriWithTimestamp.length > 2)
                        ? (kaloriWithTimestamp[2]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                    dayFour: (kaloriWithTimestamp.length > 3)
                        ? (kaloriWithTimestamp[3]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                    dayFive: (kaloriWithTimestamp.length > 4)
                        ? (kaloriWithTimestamp[4]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                    daySix: (kaloriWithTimestamp.length > 5)
                        ? (kaloriWithTimestamp[5]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                    daySeven: (kaloriWithTimestamp.length > 6)
                        ? (kaloriWithTimestamp[6]['kalori'] ?? 0)
                            .toStringAsFixed(2)
                        : hello.toString(),
                  ),
                ],
              );
            },
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
