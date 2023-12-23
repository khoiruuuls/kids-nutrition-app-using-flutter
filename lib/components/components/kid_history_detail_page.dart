// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components_button.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

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

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('nutritions')
          .doc(widget.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final nutritionData = snapshot.data!.data() as Map<String, dynamic>;

          // Now, you can access and display the nutrition data
          String nutritionName = nutritionData['name'] ?? '';
          String nutritionImage = nutritionData['image'] ?? '';
          double nutritionKalori = nutritionData['kalori'] ?? '';
          double nutritionLemak = nutritionData['lemak'] ?? '';
          double nutritionFiber = nutritionData['fiber'] ?? '';
          double nutritionWater = nutritionData['water'] ?? '';
          double nutritionProtein = nutritionData['protein'] ?? '';
          double nutritionCarbs = nutritionData['karbohidrat'] ?? '';
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
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
                                      nutritionImage,
                                      height:
                                          ConfigSize.blockSizeVertical! * 50,
                                      width:
                                          double.infinity, // Use the full width
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                              Radius.circular(paddingMin * 3),
                                          topRight:
                                              Radius.circular(paddingMin * 3),
                                        ),
                                        color: Colors.white,
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
                                      horizontal: paddingMin),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: paddingMin),
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
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("kid_nutrition")
                                              .doc(widget.id)
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                        color: ConfigColor.redAccent,
                                        text: "Hapus data",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        ComponentsBack(
                          textTitle: "Hello",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const ComponentsNoData();
        }
      },
    );
  }
}
