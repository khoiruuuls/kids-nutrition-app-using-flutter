// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_nutrition_app/main.dart';

class KidHw extends StatelessWidget {
  final String textMeasure;
  final String textTitle;
  final TextEditingController? controller;
  final String? hintText;
  final bool isNumeric;
  const KidHw({
    this.isNumeric = false,
    required this.hintText,
    required this.controller,
    required this.textMeasure,
    required this.textTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    // Choose formatters based on the isNumeric flag
    if (isNumeric) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
      ];
    }
    return Column(
      children: [
        Text(
          textTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: paddingMin),
        Row(
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(paddingMin / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    blurRadius: 4, // Spread of the shadow
                    offset: Offset(2, 2), // Shadow offset (x, y)
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(paddingMin / 2),
                  ),
                  hintText: hintText,
                ),
                inputFormatters: inputFormatters,
                keyboardType:
                    isNumeric ? TextInputType.number : TextInputType.text,
              ),
            ),
            SizedBox(width: paddingMin),
            Text(textMeasure)
          ],
        ),
      ],
    );
  }
}
