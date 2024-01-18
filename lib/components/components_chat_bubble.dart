import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/config_size.dart';

class ComponentsChatBubble extends StatelessWidget {
  final String message;
  final Color? colorContainer;
  final Color? colorText;
  final String date;
  final Color? colorDate;
  final CrossAxisAlignment crossAlignment;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const ComponentsChatBubble({
    required this.colorContainer,
    required this.colorText,
    required this.message,
    required this.date,
    required this.colorDate,
    required this.crossAlignment,
    required this.borderRadiusGeometry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 250.0, // Set your desired maximum width here
      ),
      padding: const EdgeInsets.only(
        top: paddingMin,
        bottom: paddingMin * 0.5,
        left: paddingMin,
        right: paddingMin,
      ), // Adjust as needed
      decoration: BoxDecoration(
        borderRadius: borderRadiusGeometry,
        color: colorContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: crossAlignment,
        children: [
          Text(
            message,
            style: GoogleFonts.poppins(
              color: colorText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: paddingMin * 0.5),
          Text(
            date,
            style: GoogleFonts.poppins(fontSize: 12, color: colorDate),
          ),
        ],
      ),
    );
  }
}
