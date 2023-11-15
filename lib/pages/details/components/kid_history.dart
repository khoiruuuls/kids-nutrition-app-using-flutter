// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/services/firestore.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class KidHistory extends StatefulWidget {
  final String userId;

  const KidHistory({
    required this.userId,
    super.key,
  });

  @override
  State<KidHistory> createState() => _KidHistoryState();
}

class _KidHistoryState extends State<KidHistory> {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreService.getNutritionForKid(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final nutritionList = snapshot.data!.docs.map((document) {
            final data = document.data() as Map<String, dynamic>;
            final nutritionId = data['nutritionId'] ?? '';
            final timestamp = data['timestamp'] ??
                "" as Timestamp; // Assuming 'timestamp' is the field name in Firestore
            String timestampString =
                timestamp != null ? timestamp.toDate().toString() : '';
            return {'nutritionId': nutritionId, 'timestamp': timestampString};
          }).toList();

          nutritionList
              .sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

          return Column(
            children: nutritionList.map((nutritionData) {
              final nutritionId = nutritionData['nutritionId'];

              return FutureBuilder(
                future: firestoreService.getNutritionById(nutritionId),
                builder: (context, nutritionSnapshot) {
                  if (nutritionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text("");
                  }
                  if (nutritionSnapshot.hasData) {
                    // Extract data from the retrieved document
                    final nutritionData =
                        nutritionSnapshot.data!.data() as Map<String, dynamic>;

                    // Now, you can access and display the nutrition data
                    String nutritionName = nutritionData['name'] ?? '';
                    double? nutritionKalori = nutritionData['kalori'] ?? '';
                    double? nutritionKarbohidrat =
                        nutritionData['karbohidrat'] ?? '';
                    double? nutritionLemak = nutritionData['lemak'] ?? '';
                    double? nutritionProtein = nutritionData['protein'] ?? '';
                    Timestamp timestamp = nutritionData['timestamp'];
                    String formattedDate = DateFormat('hh:mm, dd MMMM yyyy')
                        .format(timestamp.toDate());

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: paddingMin),
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
                      child: Padding(
                        padding: const EdgeInsets.all(paddingMin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nutritionName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: paddingMin),
                            ),
                            SizedBox(height: paddingMin / 2),
                            Text(formattedDate),
                            SizedBox(height: paddingMin),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Kalori : ${nutritionKalori!.toStringAsFixed(2)}'),
                                    Text(
                                        'Lemak : ${nutritionLemak!.toStringAsFixed(2)}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Protein : ${nutritionProtein!.toStringAsFixed(2)}'),
                                    Text(
                                        'Karbohidrat : ${nutritionKarbohidrat!.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text("data");
                  }
                },
              );
            }).toList(),
          );
        } else {
          return Text("Tidak ada data");
        }
      },
    );
  }
}
