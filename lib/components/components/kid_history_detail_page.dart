// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components_button.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/pages/details/kid_page.dart';

import '../../components/components_back.dart';
import '../../config/config_size.dart';
import '../../services/firestore.dart';
import '../components_no_data.dart';
import 'component_nutritions.dart';

class KidHistoryDetailPage extends StatefulWidget {
  final String id;
  KidHistoryDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<KidHistoryDetailPage> createState() => _KidHistoryDetailPageState();
}

class _KidHistoryDetailPageState extends State<KidHistoryDetailPage> {
  FirestoreService firestoreService = FirestoreService();

  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);

    deleteField() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Apakah anda yakin ingin menghapus riwayat makan ini ?",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Tidak",
                  style: GoogleFonts.poppins(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  DocumentSnapshot<Map<String, dynamic>> snapshot =
                      await FirebaseFirestore.instance
                          .collection("kid_nutrition")
                          .doc(widget.id)
                          .get();

                  String kidId = snapshot.data()?['kidId'];

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KidPage(
                        id: kidId,
                      ),
                    ),
                  );

                  await FirebaseFirestore.instance
                      .collection("kid_nutrition")
                      .doc(widget.id)
                      .delete();
                },
                child: Text(
                  "Ya",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<dynamic>(
          stream: FirebaseFirestore.instance
              .collection('nutritions')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final nutritionData =
                  snapshot.data!.data() as Map<String, dynamic>;

              // Now, you can access and display the nutrition data
              String nutritionName = nutritionData['name'] ?? '';

              String nutritionImage = nutritionData['image'] ?? '';
              double nutritionKalori = nutritionData['kalori'] ?? '';
              double nutritionLemak = nutritionData['lemak'] ?? '';
              double nutritionFiber = nutritionData['fiber'] ?? '';
              double nutritionWater = nutritionData['water'] ?? '';
              double nutritionProtein = nutritionData['protein'] ?? '';
              double nutritionCarbs = nutritionData['karbohidrat'] ?? '';
              double nutritionTotal = nutritionData['total'] ?? '';
              var timestamp = nutritionData["timestamp"];
              String formattedDate =
                  DateFormat('dd MMM yyyy').format(timestamp.toDate());

              bool isImageExpired(String imageUrl) {
                Uri uri = Uri.parse(imageUrl);

                // Check if the URL contains the necessary parameters
                if (uri.queryParameters.containsKey('X-Amz-Date') &&
                    uri.queryParameters.containsKey('X-Amz-Expires')) {
                  // Extract X-Amz-Date and X-Amz-Expires from the URL
                  String? requestDateTime = uri.queryParameters['X-Amz-Date'];
                  int? expirationTimestamp =
                      int.tryParse(uri.queryParameters['X-Amz-Expires']!);

                  if (requestDateTime != null && expirationTimestamp != null) {
                    // Parse X-Amz-Date and calculate expiration time
                    DateTime requestTime = DateTime.parse(requestDateTime);
                    DateTime expirationTime =
                        requestTime.add(Duration(seconds: expirationTimestamp));
                    // Get the current time
                    DateTime currentTime = DateTime.now();

                    // Return true if the expiration time is in the past (expired), false otherwise
                    return expirationTime.isBefore(currentTime);
                  }
                }

                // Return false if the necessary parameters are not present or if parsing fails
                return false;
              }

              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: ConfigSize.blockSizeVertical! * 45,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    child: Image.network(
                                      isImageExpired(nutritionImage)
                                          ? 'https://bit.ly/kids-nutrition-app-full-image-expired' // Default or placeholder image URL
                                          : nutritionImage,
                                      height:
                                          ConfigSize.blockSizeVertical! * 50,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        // Handle the error, show a local placeholder image
                                        return Image.asset(
                                          'assets/logo.png', // Local placeholder image path
                                          height:
                                              ConfigSize.blockSizeVertical! *
                                                  50,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            paddingMin * 3,
                                          ),
                                          topRight: Radius.circular(
                                            paddingMin * 3,
                                          ),
                                        ),
                                        color: Colors.grey.shade50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: paddingMin,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: paddingMin,
                                        ),
                                        child: Text(
                                          nutritionName,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: paddingMin * 1.5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: paddingMin,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Tanggal",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  formattedDate,
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Total Nutrisi",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  nutritionTotal
                                                      .toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: paddingMin),
                                      ComponentsNutritions(
                                        carbohydrates:
                                            nutritionCarbs.toStringAsFixed(2),
                                        fiber:
                                            nutritionFiber.toStringAsFixed(2),
                                        water:
                                            nutritionWater.toStringAsFixed(2),
                                        energy:
                                            nutritionKalori.toStringAsFixed(2),
                                        fat: nutritionLemak.toStringAsFixed(2),
                                        protein:
                                            nutritionProtein.toStringAsFixed(2),
                                      ),
                                      SizedBox(height: paddingMin),
                                      ComponentsButton(
                                        onTap: deleteField,
                                        color: ConfigColor.redAccent,
                                        text: "Hapus data",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        ComponentsBack(
                          textTitle: "Riwayat makanan",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const ComponentsNoData();
            }
          },
        ),
      ),
    );
  }
}
