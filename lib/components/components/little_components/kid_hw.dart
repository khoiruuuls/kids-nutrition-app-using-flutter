// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/config_size.dart';

class KidHw extends StatelessWidget {
  final String textMeasure;
  final String textTitle;
  final TextEditingController? controller;
  final double? hintText;
  final bool isNumeric;
  const KidHw({
    this.isNumeric = false,
    this.hintText,
    required this.controller,
    required this.textMeasure,
    required this.textTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    controller!.addListener(() {
      final enteredValue = double.tryParse(controller!.text);
      if (enteredValue != null && enteredValue > 250) {
        controller!.text = '200';
      }
    });

    if (isNumeric) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ];
    } else {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
      ];
    }
    return Column(
      children: [
        Text(
          textTitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: paddingMin),
        Row(
          children: [
            Container(
              width: 100,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: kInputBorder,
                  errorBorder: kInputBorder,
                  focusedBorder: sInputBorder,
                  enabledBorder: kInputBorder,
                  hintText: hintText == null ? "50" : hintText.toString(),
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: paddingMin * 5 / 4,
                    horizontal: paddingMin * 3 / 2,
                  ),
                  counterText: '',
                ),
                inputFormatters: inputFormatters,
                keyboardType:
                    isNumeric ? TextInputType.number : TextInputType.text,
                maxLength: 5,
              ),
            ),
            SizedBox(width: paddingMin),
            Text(
              textMeasure,
              style: GoogleFonts.poppins(),
            )
          ],
        ),
      ],
    );
  }
}
