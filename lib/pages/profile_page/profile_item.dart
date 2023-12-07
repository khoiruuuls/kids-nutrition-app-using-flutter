// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/pages/recipe_page/detail_page.dart';
import 'package:line_icons/line_icon.dart';

import '../../config/config_size.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingMin / 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Khoirul Post",
                style: GoogleFonts.poppins(
                  fontSize: paddingMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "View all",
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: ConfigSize.blockSizeVertical! * 2.5),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.only(
                      bottom: ConfigSize.blockSizeVertical! * 2.5,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
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
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(paddingMin),
                            child: Image.network(
                              "https://images.unsplash.com/photo-1512100356356-de1b84283e18?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
                                "News: Politics",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ConfigSize.blockSizeVertical! * 1,
                              ),
                              Text(
                                "Dengan SaveFrom.Net, Anda dapat mengunduh video atau musik dengan mudah dan gratis. Tidak diperlukan instalasi software tambahan atau mencari alternatif pengunduh video format MP4 lainnya.",
                                maxLines: 2,
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              SizedBox(
                                  height: ConfigSize.blockSizeVertical! * 1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      LineIcon.calendar(),
                                      SizedBox(
                                        width: ConfigSize.blockSizeHorizontal! *
                                            2.5,
                                      ),
                                      Text(
                                        "20 Jan 2023",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      LineIcon.clock(),
                                      SizedBox(
                                        width: ConfigSize.blockSizeHorizontal! *
                                            2.5,
                                      ),
                                      Text(
                                        "09.00",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
