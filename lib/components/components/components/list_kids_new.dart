// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config_size.dart';

class ListKidsNew extends StatelessWidget {
  final String name;
  final String? role;
  final String id;
  final String date;
  final String time;
  final Function()? onTap;
  const ListKidsNew({
    this.role,
    required this.time,
    required this.date,
    required this.onTap,
    required this.id,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: EdgeInsets.only(
          bottom: ConfigSize.blockSizeVertical! * 0.5,
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(paddingMin),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: Offset(0, 3),
                    color: Colors.grey.shade200,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(paddingMin),
                child: Image.network(
                  "https://getillustrations.b-cdn.net//photos/pack/3d-avatar-male_lg.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: ConfigSize.blockSizeVertical! * 2.5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: paddingMin,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role ?? "No data.",
                    style: GoogleFonts.poppins(
                      fontSize: paddingMin * 0.75,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: ConfigSize.blockSizeVertical! * 1),
                  Text(
                    "${time}, ${date}",
                    style: GoogleFonts.poppins(
                      fontSize: paddingMin * 0.85,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
