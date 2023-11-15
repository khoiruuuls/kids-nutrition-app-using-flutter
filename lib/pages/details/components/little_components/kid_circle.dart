// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';

class KidCircle extends StatelessWidget {
  final String textCategory;
  final String? total;
  const KidCircle({
    required this.total,
    required this.textCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textCategory,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: paddingMin * 3 / 2),
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade800,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              total.toString(),
              style: TextStyle(
                fontSize: fontHeading,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: paddingMin / 2),
      ],
    );
  }
}
