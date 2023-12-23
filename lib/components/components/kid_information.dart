// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/model/model_age_counter.dart';

import '../../config/config_color.dart';
import '../../config/config_size.dart';
import '../../services/firestore.dart';
import '../components_scrolled_horizontal.dart';

class KidInformation extends StatefulWidget {
  final String id;

  const KidInformation({
    required this.id,
    super.key,
  });

  @override
  State<KidInformation> createState() => _KidInformationState();
}

class _KidInformationState extends State<KidInformation> {
  FirestoreService firestoreService = FirestoreService();

  String calculateBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 24.9) {
      return "Normal";
    } else if (bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    AgeCounter ageCounter = AgeCounter();

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!;

          final weight = data['weight'];
          final height = data['height'];
          final dateBirth = data['dateBirth'];
          final gender = data['gender'];

          if (weight != null &&
              height != null &&
              dateBirth != null &&
              gender != null) {
            final double heightM = height / 100;
            final BMI = weight / (heightM * heightM);
            String bmiCategory = calculateBMICategory(BMI);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: ConfigSize.blockSizeHorizontal! * 3,
                    right: ConfigSize.blockSizeHorizontal! * 3,
                    bottom: ConfigSize.blockSizeVertical! * 2,
                    top: ConfigSize.blockSizeVertical! * 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(paddingMin),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Berat Badan",
                                  style: GoogleFonts.poppins(
                                    color: ConfigColor.darkBlue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  '${data['weight']} kg',
                                  style: GoogleFonts.poppins(
                                    color: ConfigColor.darkBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: ConfigSize.blockSizeVertical! * 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: ConfigColor.darkBlue,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Tinggi Badan",
                                  style: GoogleFonts.poppins(
                                    color: ConfigColor.darkBlue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "${data['height']} cm",
                                  style: GoogleFonts.poppins(
                                    color: ConfigColor.darkBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ConfigSize.blockSizeVertical),
                      Text(
                        bmiCategory,
                        style: GoogleFonts.poppins(
                          fontSize: paddingMin,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: paddingMin),
                ComponentsScrolledHorizontal(
                  id: widget.id,
                  age: ageCounter.calculateAge(data['dateBirth']),
                  gender: data['gender'],
                ),
              ],
            );
          } else {
            return Text('No data available');
          }
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
