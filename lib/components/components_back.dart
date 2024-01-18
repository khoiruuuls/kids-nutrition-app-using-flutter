// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../config/config_size.dart';
import 'components_menu.dart';

class ComponentsBack extends StatelessWidget {
  final String textTitle;
  final String? id;
  final Function? onTap;
  const ComponentsBack({
    required this.textTitle,
    this.onTap,
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingMin),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap as void Function()? ?? () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  Container(
                    height: paddingMin * 3,
                    width: paddingMin * 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(paddingMin),
                      border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: LineIcon.arrowLeft(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: paddingMin),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: paddingMin * 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paddingMin),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingMin),
                  child: Center(
                    child: Text(
                      textTitle,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (id != null) ...[
            SizedBox(width: paddingMin),
            ComponentsMenu(id: id!),
          ],
        ],
      ),
    );
  }
}
