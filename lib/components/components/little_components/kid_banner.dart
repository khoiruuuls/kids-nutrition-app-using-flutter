// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../../../config/config_size.dart';

class KidBanner extends StatelessWidget {
  final String text;
  const KidBanner({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white
          ),
        ),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ConfigColor.darkBlue,
        borderRadius: BorderRadius.circular(paddingMin / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
