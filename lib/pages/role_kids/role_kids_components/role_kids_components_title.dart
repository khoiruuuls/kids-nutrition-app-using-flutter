// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config_size.dart';
import 'role_kids_components_menu.dart';

class RoleKidsComponentsTitle extends StatelessWidget {
  final String textTitle;
  final String? id;
  const RoleKidsComponentsTitle({
    required this.textTitle,
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingMin),
      child: Row(
        children: [
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
                child: Center(
                  child: Text(
                    textTitle,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (id != null) ...[
            SizedBox(width: paddingMin),
            KidsRoleComponentsMenu(id: id!),
          ],
        ],
      ),
    );
  }
}
