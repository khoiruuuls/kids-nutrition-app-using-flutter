// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';

class ButtonKids extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const ButtonKids({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(paddingMin * 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              blurRadius: 5, // Spread of the shadow
              offset: Offset(4, 4), // Shadow offset (x, y)
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: paddingMin * 4,
          vertical: paddingMin,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
