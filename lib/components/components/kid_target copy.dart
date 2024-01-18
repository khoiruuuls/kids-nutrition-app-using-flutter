import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components_chart.dart';
import 'package:kids_nutrition_app/components/components_get_user_data.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';
import '../../config/config_size.dart';
import '../../services/firestore.dart';
import 'little_components/kid_banner.dart';

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
      totalSingleNutrition,
      totalAll;
  double? inPercentKalori,
      inPercentProtein,
      inPercentLemak,
      inPercentKarbohidrat,
      inPercentSerat,
      inPercentAir;

  @override
  Widget build(BuildContext context) {
    const double initial = 0;

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
          List<Future<double>> singleFutures = [];

          for (var document in snapshot.data!.docs) {
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
            singleFutures.add(getNutritionData('total'));
          }

          return FutureBuilder(
            future: Future.wait([
              ...kaloriFutures,
              ...proteinFutures,
              ...lemakFutures,
              ...karbohidratFutures,
              ...seratFutures,
              ...airFutures,
              ...singleFutures,
            ]),
            builder: (context, futuresSnapshot) {
              if (futuresSnapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
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
                    lemakFutures.length,
              );
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
                    karbohidratFutures.length,
                kaloriFutures.length +
                    proteinFutures.length +
                    lemakFutures.length +
                    seratFutures.length +
                    karbohidratFutures.length +
                    airFutures.length,
              );

              List<double?> totalSingleList = futuresSnapshot.data!.sublist(
                kaloriFutures.length +
                    proteinFutures.length +
                    lemakFutures.length +
                    seratFutures.length +
                    karbohidratFutures.length +
                    airFutures.length,
                kaloriFutures.length +
                    proteinFutures.length +
                    lemakFutures.length +
                    seratFutures.length +
                    karbohidratFutures.length +
                    airFutures.length +
                    singleFutures.length,
              );

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

              List<Map<String, dynamic>> totalSingleNutrition = [];
              Map<String, double> dateSumMap = {};

              for (int i = 0; i < totalSingleList.length; i++) {
                final timestamp = snapshot.data!.docs[i]['timestamp'];
                final date = timestamp.toDate().toString().split(' ')[0];
                final total = totalSingleList[i];

                dateSumMap[date] = (dateSumMap[date] ?? 0) + (total ?? 0);

                totalSingleNutrition
                    .add({'timestamp': timestamp, 'total': total});
              }

              totalSingleNutrition
                  .sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

              Map<String, String> chartData = {};

              dateSumMap.forEach((date, total) {
                chartData[date] = total.toStringAsFixed(2);
              });

              DateTime currentDate = DateTime.now();
              List<String> days = [];

              for (int i = 0; i < 7; i++) {
                DateTime pastDate = currentDate.subtract(Duration(days: i));
                String formattedDate =
                    pastDate.toLocal().toString().split(' ')[0];

                days.add(formattedDate);
              }

              List<DateTime> past7Dates = List.generate(
                7,
                (index) => currentDate.subtract(Duration(days: index)),
              );

              List<String> formattedDates = past7Dates
                  .map((date) => DateFormat('dd/MM').format(date))
                  .toList();

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
                  const SizedBox(height: paddingMin),
                  const KidBanner(text: "Riwayat Makan"),
                  const SizedBox(height: paddingMin),
                  ComponentsChart(
                    dayOne: chartData[days[0]] ?? initial.toString(),
                    dayTwo: chartData[days[1]] ?? initial.toString(),
                    dayThree: chartData[days[2]] ?? initial.toString(),
                    dayFour: chartData[days[3]] ?? initial.toString(),
                    dayFive: chartData[days[4]] ?? initial.toString(),
                    daySix: chartData[days[5]] ?? initial.toString(),
                    daySeven: chartData[days[6]] ?? initial.toString(),
                    dateOne: formattedDates[0],
                    dateTwo: formattedDates[1],
                    dateThree: formattedDates[2],
                    dateFour: formattedDates[3],
                    dateFive: formattedDates[4],
                    dateSix: formattedDates[5],
                    dateSeven: formattedDates[6],
                  )
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
