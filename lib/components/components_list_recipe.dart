// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config_size.dart';

class ComponentsListRecipe extends StatelessWidget {
  final int itemCount;
  final Function(int)? onTap;
  final String Function(int) image;
  final String Function(int) label;

  const ComponentsListRecipe({
    required this.itemCount,
    required this.onTap,
    required this.image,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 25,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          padding: EdgeInsets.symmetric(horizontal: paddingMin),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onTap!(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: index == 1 ? 280 : 240,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(paddingMin),
                      child: Container(
                        child: Image.network(
                          image(index),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Text(
                            label(index),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
