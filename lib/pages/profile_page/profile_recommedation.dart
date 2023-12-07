import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/config_size.dart';

class ProfileRecommendation extends StatelessWidget {
  const ProfileRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingMin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest from Khoirul",
                style: GoogleFonts.poppins(
                  fontSize: paddingMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ConfigSize.blockSizeVertical! * 2.5),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  right: ConfigSize.blockSizeHorizontal! * 2.5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(paddingMin),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1512100356356-de1b84283e18?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
