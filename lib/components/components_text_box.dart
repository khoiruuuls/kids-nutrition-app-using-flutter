// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../config/config_color.dart';
import '../config/config_size.dart';

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
    return Container(
      padding: EdgeInsets.only(
        left: paddingMin,
        bottom: paddingMin,
      ),
      decoration: BoxDecoration(
        color: ConfigColor.darkBlue,
        borderRadius: BorderRadius.circular(paddingMin),
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
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: paddingMin,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: LineIcon.edit(
                  color: Colors.white,
                ),
                onPressed: onPressed,
              ),
            ],
          ),
          SizedBox(height: ConfigSize.blockSizeVertical! * 0.1),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
