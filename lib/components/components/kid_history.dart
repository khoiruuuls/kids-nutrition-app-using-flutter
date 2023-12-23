import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components/kid_history_detail_page.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../../config/config_color.dart';
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
    ConfigSize().init(context);
    return StreamBuilder(
      stream: firestoreService.getNutritionForKid(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final nutritionList = snapshot.data!.docs.map((document) {
            final data = document.data() as Map<String, dynamic>;
            final nutritionId = data['nutritionId'] ?? '';
            final timestamp = data['timestamp'] ?? "" as Timestamp;
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
                    return const Text("");
                  }
                  if (nutritionSnapshot.hasData) {
                    final nutritionData =
                        nutritionSnapshot.data!.data() as Map<String, dynamic>;

                    // Now, you can access and display the nutrition data
                    String nutritionName = nutritionData['name'] ?? '';
                    String nutritionImage = nutritionData['image'] ?? '';
                    var timestamp = nutritionData["timestamp"];
                    String formattedDate = DateFormat('hh : mm, dd MMMM yyyy')
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          kBorderRadius20,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 0,
                                            offset: const Offset(0, 18),
                                            blurRadius: 18,
                                            color: kBlack.withOpacity(0.1),
                                          )
                                        ],
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            nutritionImage,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      kBorderRadius20),
                                                  bottomRight: Radius.circular(
                                                      kBorderRadius20),
                                                ),
                                                gradient: kLinearGradientBlack,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                kPadding20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      nutritionName,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: kWhite,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: paddingMin,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            paddingMin * 0.25),
                                                    Text(
                                                      formattedDate,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: kWhite,
                                                        fontSize:
                                                            paddingMin * 0.75,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const ComponentsNoData();
                  }
                },
              );
            }).toList(),
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
