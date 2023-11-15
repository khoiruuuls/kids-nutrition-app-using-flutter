// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/components/button_kids.dart';
import 'package:kids_nutrition_app/pages/components/input_kids.dart';
import 'package:kids_nutrition_app/pages/details/components/kid_nav.dart';
import 'package:kids_nutrition_app/pages/details/kid_page.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../../main.dart';

class AddNutritionPage extends StatefulWidget {
  final String kidDocId;

  const AddNutritionPage({required this.kidDocId, Key? key}) : super(key: key);

  @override
  State<AddNutritionPage> createState() => _AddNutritionPageState();
}

class _AddNutritionPageState extends State<AddNutritionPage> {
  FirestoreService firestoreService = FirestoreService();

  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textKaloriController = TextEditingController();
  final TextEditingController textKarbohidratController =
      TextEditingController();
  final TextEditingController textLemakController = TextEditingController();
  final TextEditingController textProteinController = TextEditingController();

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      context: context,
      builder: (BuildContext context) {
        // Display the modal bottom sheet content
        return Container(
          height: 100,
          child: Center(
            child: Text(
              "Berhasil ditambahkan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );

    // Close the modal bottom sheet after 1 second
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KidNav(docId: "", textTitle: "Tambah Data Nutrisi"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: paddingMin * 2),
                  InputKids(
                      hintText: "Masukan Nama",
                      text: "Nama",
                      controller: textNameController),
                  SizedBox(height: paddingMin),
                  InputKids(
                      hintText: "Masukan Kalori",
                      text: "Kalori",
                      controller: textKaloriController),
                  SizedBox(height: paddingMin),
                  InputKids(
                      hintText: "Masukan Karbohidrat",
                      text: "Karbohidrat",
                      controller: textKarbohidratController),
                  SizedBox(height: paddingMin),
                  InputKids(
                      hintText: "Masukan Lemak",
                      text: "Lemak",
                      controller: textLemakController),
                  SizedBox(height: paddingMin),
                  InputKids(
                      hintText: "Masukan Protein",
                      text: "Protein",
                      controller: textProteinController),
                  SizedBox(height: paddingMin * 2),
                  ButtonKids(
                    text: "Masukan Nutrisi",
                    onTap: () async {
                      // Add nutrition data to Firestore and capture the DocumentReference
                      final DocumentReference nutritionReference =
                          await firestoreService.addNutrition(
                        textNameController.text,
                        double.parse(textKaloriController.text),
                        double.parse(textKarbohidratController.text),
                        double.parse(textLemakController.text),
                        double.parse(textProteinController.text),
                      );

                      // Extract the nutritionId from the DocumentReference's ID
                      String nutritionId = nutritionReference.id;

                      // Create a relationship between the child (kidId) and the added nutrition data (nutritionId)
                      await firestoreService.addKidNutritionRelation(
                          widget.kidDocId, nutritionId);

                      // Clear the input fields
                      textNameController.clear();
                      textKaloriController.clear();
                      textKarbohidratController.clear();
                      textLemakController.clear();
                      textProteinController.clear();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KidPage(
                            docId: widget.kidDocId,
                          ),
                        ),
                      );

                      _showModalBottomSheet(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
