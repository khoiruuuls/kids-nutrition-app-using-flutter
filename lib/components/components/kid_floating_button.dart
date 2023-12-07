// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../../config/config_size.dart';
import '../../pages/recipe_page/recipe_page.dart';

class KidFloatingButton extends StatelessWidget {
  final String id;
  final IconData? icon;
  const KidFloatingButton({
    required this.icon,
    required this.id,
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
              id: id,
            ),
          ),
        )
      },
      child: Material(
        elevation: 4.0, // Add elevation for a subtle shadow
        borderRadius: BorderRadius.circular(paddingMin),
        color: ConfigColor.darkBlue,
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
