// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components/kid_history_detail_page.dart';
import 'package:kids_nutrition_app/services/firestore.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../config/config_size.dart';

class KidHistory extends StatefulWidget {
  final String id;

  const KidHistory({
    required this.id,
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
      stream: firestoreService.getNutritionForKid(widget.id),
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
                    String nutritionImage = nutritionData['image'] ?? '';
                    double? nutritionKalori = nutritionData['kalori'] ?? '';
                    double? nutritionKarbohidrat =
                        nutritionData['karbohidrat'] ?? '';
                    double? nutritionLemak = nutritionData['lemak'] ?? '';
                    double? nutritionProtein = nutritionData['protein'] ?? '';
                    Timestamp timestamp = nutritionData['timestamp'];
                    String formattedDate = DateFormat('hh : mm, dd MMM yyyy')
                        .format(timestamp.toDate());

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                KidHistoryDetailPage(id: nutritionId),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), // Set your desired border radius
                                child: CachedNetworkImage(
                                  imageUrl: nutritionImage,
                                  placeholder: (context, url) => Placeholder(),
                                  errorWidget: (context, url, error) =>
                                      Placeholder(), // Handle errors here
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: paddingMin,
                                        vertical: paddingMin / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(paddingMin / 2),
                                        ),
                                      ),
                                      child: Text(
                                        nutritionName,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: paddingMin,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: paddingMin,
                          )
                        ],
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
