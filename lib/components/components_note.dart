import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../config/config_size.dart';
import '../config/config_color.dart';

class ComponentsNote extends StatelessWidget {
  const ComponentsNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Berlebih",
                    style: GoogleFonts.poppins(
                      color: ConfigColor.darkBlue,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: paddingMin * 0.5),
                  const LineIcon.arrowUp(
                    color: ConfigColor.darkBlue,
                    size: 13,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: ConfigSize.blockSizeVertical! * 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: ConfigColor.darkBlue,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Normal",
                    style: GoogleFonts.poppins(
                      color: ConfigColor.darkBlue,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: paddingMin * 0.5),
                  const LineIcon.thumbsUp(
                    color: ConfigColor.darkBlue,
                    size: 13,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: ConfigSize.blockSizeVertical! * 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: ConfigColor.darkBlue,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Kurang",
                    style: GoogleFonts.poppins(
                      color: ConfigColor.darkBlue,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: paddingMin * 0.5),
                  const LineIcon.arrowDown(
                    color: ConfigColor.darkBlue,
                    size: 13,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
