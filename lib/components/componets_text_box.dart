// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';

class ComponentsTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final Function()? onPressed;

  const ComponentsTextBox({
    required this.text,
    required this.sectionName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingMin),
      child: Container(
        padding: EdgeInsets.only(
          left: paddingMin,
          bottom: paddingMin,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(paddingMin / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(
                    fontSize: paddingMin,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey.shade800,
                  ),
                  onPressed: onPressed,
                ),
              ],
            ),
            SizedBox(height: paddingMin / 2),
            Text(text),
          ],
        ),
      ),
    );
  }
}
