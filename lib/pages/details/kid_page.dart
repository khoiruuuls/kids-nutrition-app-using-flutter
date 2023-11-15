// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/details/components/kid_floating_button.dart';
import 'package:kids_nutrition_app/pages/details/components/kid_main.dart';
import 'package:kids_nutrition_app/pages/details/components/kid_nav.dart';

class KidPage extends StatelessWidget {
  final String docId;

  const KidPage({
    required this.docId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KidNav(
              docId: docId,
              textTitle: "Data Anak",
              editIcon: Icons.edit_document,
              deleteIcon: Icons.delete,
            ),
            KidMain(docId: docId)
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16, // Adjust the position as needed
            right: 8, // Adjust the position as needed
            child: KidFloatingButton(
              docId: docId,
              icon: Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
