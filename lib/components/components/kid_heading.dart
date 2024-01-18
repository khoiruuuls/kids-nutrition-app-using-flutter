// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/model/model_age_counter.dart';
import '../../config/config_size.dart';
import 'package:kids_nutrition_app/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KidHeading extends StatefulWidget {
  final String id;

  KidHeading({
    required this.id,
    super.key,
  });

  @override
  State<KidHeading> createState() => _KidHeadingState();
}

class _KidHeadingState extends State<KidHeading> {
  FirestoreService firestoreService = FirestoreService();
  AgeCounter ageCounter = AgeCounter();
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(""); // or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!;

          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingMin / 2,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(paddingMin),
                      child: Image.network(
                        data['photo'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: paddingMin * 2),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data['name'] != null)
                              Text(
                                data['name'],
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: paddingMin,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                maxLines: 1, // Set to 1 line
                                overflow: TextOverflow.ellipsis,
                              ),
                            SizedBox(height: paddingMin / 4),
                            if (data['gender'] != null &&
                                data['dateBirth'] != null)
                              Text(
                                "${data['gender']}, ${ageCounter.calculateAge(data['dateBirth']).toString()} tahun",
                                style: GoogleFonts.poppins(),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('');
        }
      },
    );
  }
}
