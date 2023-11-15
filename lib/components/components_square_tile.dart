// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';

class ComponentsSquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const ComponentsSquareTile({
    required this.onTap,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(paddingMin),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(paddingMin),
          color: Colors.white,
        ),
        child: Image.asset(
          imagePath,
          height: 30,
          color: Colors.blue.shade300,
        ),
      ),
    );
  }
}
