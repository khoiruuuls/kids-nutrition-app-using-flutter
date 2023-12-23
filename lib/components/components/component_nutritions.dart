// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/config_color.dart';
import '../../config/config_size.dart';

class ComponentsNutritions extends StatelessWidget {
  final String carbohydrates;
  final String fiber;
  final String water;
  final String energy;
  final String fat;
  final String protein;
  final String? text;

  const ComponentsNutritions({
    required this.carbohydrates,
    required this.fiber,
    required this.water,
    required this.energy,
    required this.fat,
    required this.protein,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ConfigSize.blockSizeHorizontal! * 3,
        right: ConfigSize.blockSizeHorizontal! * 3,
        bottom: ConfigSize.blockSizeHorizontal! * 9,
        top: ConfigSize.blockSizeVertical! * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(paddingMin),
        color: ConfigColor.darkBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          text != null
              ? Text(
                  text!,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: paddingMin,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(height: ConfigSize.blockSizeVertical! * 2.5),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Kalori",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      energy,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: ConfigSize.blockSizeVertical! * 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Karbohidrat",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      carbohydrates,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: ConfigSize.blockSizeVertical! * 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Protein",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      protein,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ConfigSize.blockSizeVertical! * 2.5),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Serat",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      fiber,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: ConfigSize.blockSizeVertical! * 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Kadar Air",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      water,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: ConfigSize.blockSizeVertical! * 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Lemak",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      fat,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
