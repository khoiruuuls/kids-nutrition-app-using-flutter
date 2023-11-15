// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/recipe/recipe_page.dart';

import '../../../main.dart';

class KidFloatingButton extends StatelessWidget {
  final String docId;
  final IconData? icon;
  const KidFloatingButton({
    required this.icon,
    required this.docId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipePage(
              kidDocId: docId,
            ),
          ),
        )
      },
      child: Material(
        elevation: 4.0, // Add elevation for a subtle shadow
        borderRadius: BorderRadius.circular(paddingMin),
        color: Colors.blue.shade300,
        child: Padding(
          padding: const EdgeInsets.all(paddingMin),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24.0, // Adjust the icon size as needed
          ),
        ),
      ),
    );
  }
}
