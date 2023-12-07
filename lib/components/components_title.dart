// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../config/config_size.dart';

class ComponentsTitle extends StatelessWidget {
  final String textTitle;
  final String? id;
  const ComponentsTitle({
    required this.textTitle,
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: paddingMin,
        right: paddingMin,
        top: paddingMin,
        bottom: paddingMin / 2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: paddingMin * 3.5,
                decoration: BoxDecoration(
                  color: ConfigColor.darkBlue,
                  borderRadius: BorderRadius.circular(paddingMin),
                  border: Border.all(color: ConfigColor.darkBlue),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    textTitle,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
