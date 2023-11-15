// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element, avoid_print, void_checks, unnecessary_null_comparison, sort_child_properties_last, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/details/components/little_components/kid_banner.dart';
import 'package:kids_nutrition_app/pages/details/components/little_components/kid_circle.dart';
import '../../../main.dart';
import '../../../services/firestore.dart';

class KidTarget extends StatefulWidget {
  final String userId;
  const KidTarget({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<KidTarget> createState() => _KidTargetState();
}

class _KidTargetState extends State<KidTarget> {
  FirestoreService firestoreService = FirestoreService();
  double? totalKalori = 0;
  double? totalProtein = 0;
  double? totalLemak = 0;
  double? totalKarbohidrat = 0;
  double? totalAll = 0;
  double? inPercentKalori = 0;
  double? inPercentProtein = 0;
  double? inPercentLemak = 0;
  double? inPercentKarbohidrat = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreService.getNutritionForKid(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // List to store individual kalori, protein, lemak, and karbohidrat futures
          List<Future<double>> kaloriFutures = [];
          List<Future<double>> proteinFutures = [];
          List<Future<double>> lemakFutures = [];
          List<Future<double>> karbohidratFutures = [];

          snapshot.data!.docs.forEach((document) {
            final data = document.data() as Map<String, dynamic>;
            final nutritionId = data['nutritionId'] ?? '';

            // Add the kalori future to the list
            kaloriFutures.add(
              firestoreService.getNutritionById(nutritionId).then((value) {
                final nutritionData = value.data() as Map<String, dynamic>;
                double? nutritionKalori = nutritionData['kalori'] as double?;
                return nutritionKalori ?? 0;
              }),
            );

            // Add the protein future to the list
            proteinFutures.add(
              firestoreService.getNutritionById(nutritionId).then((value) {
                final nutritionData = value.data() as Map<String, dynamic>;
                double? nutritionProtein = nutritionData['protein'] as double?;
                return nutritionProtein ?? 0;
              }),
            );

            // Add the lemak future to the list
            lemakFutures.add(
              firestoreService.getNutritionById(nutritionId).then((value) {
                final nutritionData = value.data() as Map<String, dynamic>;
                double? nutritionLemak = nutritionData['lemak'] as double?;
                return nutritionLemak ?? 0;
              }),
            );

            // Add the karbohidrat future to the list
            karbohidratFutures.add(
              firestoreService.getNutritionById(nutritionId).then((value) {
                final nutritionData = value.data() as Map<String, dynamic>;
                double? nutritionKarbohidrat =
                    nutritionData['karbohidrat'] as double?;
                return nutritionKarbohidrat ?? 0;
              }),
            );
          });

          // Wait for all FutureBuilder widgets to complete before calculating totals
          return FutureBuilder(
            future: Future.wait([
              ...kaloriFutures,
              ...proteinFutures,
              ...lemakFutures,
              ...karbohidratFutures
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

              // Calculate the totals
              totalKalori = kaloriList.fold(
                  0, (previous, current) => previous! + current!);
              totalProtein = proteinList.fold(
                  0, (previous, current) => previous! + current!);
              totalLemak = lemakList.fold(
                  0, (previous, current) => previous! + current!);
              totalKarbohidrat = karbohidratList.fold(
                  0, (previous, current) => previous! + current!);

              totalAll = totalKalori! +
                  totalProtein! +
                  totalLemak! +
                  totalKarbohidrat!;

              inPercentKalori = totalKalori! * 100 / totalAll!;
              inPercentProtein = totalProtein! * 100 / totalAll!;
              inPercentLemak = totalLemak! * 100 / totalAll!;
              inPercentKarbohidrat = totalKarbohidrat! * 100 / totalAll!;

              // Display the totals
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: paddingMin, vertical: paddingMin),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paddingMin / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300, // Shadow color
                      blurRadius: 4, // Spread of the shadow
                      offset: Offset(0, 2), // Shadow offset (x, y)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    KidBanner(text: "Summary"),
                    SizedBox(height: paddingMin),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KidCircle(
                          textCategory: "Kalori",
                          total: (inPercentKalori != null &&
                                  !inPercentKalori!.isNaN)
                              ? "${inPercentKalori!.toStringAsFixed(2)} %"
                              : "0.00 %",
                        ),
                        KidCircle(
                          textCategory: "Karbohidrat",
                          total: (inPercentKarbohidrat != null &&
                                  !inPercentKarbohidrat!.isNaN)
                              ? "${inPercentKarbohidrat!.toStringAsFixed(2)} %"
                              : "0.00 %",
                        ),
                      ],
                    ),
                    SizedBox(height: paddingMin),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        KidCircle(
                          textCategory: "Lemak",
                          total:
                              (inPercentLemak != null && !inPercentLemak!.isNaN)
                                  ? "${inPercentLemak!.toStringAsFixed(2)} %"
                                  : "0.00 %",
                        ),
                        KidCircle(
                          textCategory: "Protein",
                          total: (inPercentProtein != null &&
                                  !inPercentProtein!.isNaN)
                              ? "${inPercentProtein!.toStringAsFixed(2)} %"
                              : "0.00 %",
                        ),
                      ],
                    ),
                  ],
                ),
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
