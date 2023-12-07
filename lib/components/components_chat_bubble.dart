// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/config_size.dart';

class ComponentsChatBubble extends StatelessWidget {
  final String message;
  final Color? colorContainer;
  final Color? colorText;

  const ComponentsChatBubble({
    required this.colorContainer,
    required this.colorText,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 250.0, // Set your desired maximum width here
      ),
      child: Container(
        padding: EdgeInsets.all(paddingMin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(paddingMin * 0.85),
          color: colorContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: GoogleFonts.poppins(
            color: colorText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
