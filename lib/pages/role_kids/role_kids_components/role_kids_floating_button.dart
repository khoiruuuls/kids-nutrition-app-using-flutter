// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../../../config/config_size.dart';
import '../role_kids_recipe_page/role_kids_recipe_page.dart';

class RoleKidsFloatingButton extends StatelessWidget {
  final String id;
  final IconData? icon;
  const RoleKidsFloatingButton({
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
            builder: (context) => RoleKidsRecipePage(
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
