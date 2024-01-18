// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../../config/config_class.dart';
import '../../config/config_size.dart';
import 'kid_heading.dart';
import 'kid_history.dart';
import 'kid_information.dart';

class KidMain extends StatelessWidget {
  final String id;
  const KidMain({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(paddingMin),
              child: Column(
                children: [
                  KidHeading(id: id),
                  SizedBox(height: paddingMin),
                  KidInformation(id: id),
                  SizedBox(height: paddingMin * 1.5),
                  LineDeviderHorizontal(
                    widthLine: 70,
                    chooseColor: ConfigColor.darkBlue,
                  ),
                  SizedBox(height: paddingMin * 0.75),
                  Text(
                    "Note : Maksimal nutrisi perhari 10000",
                    style: GoogleFonts.poppins(
                      color: ConfigColor.darkBlue,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: paddingMin),
                  KidHistory(id: id),
                  SizedBox(height: paddingMin * 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
