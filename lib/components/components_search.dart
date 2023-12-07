// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../config/config_size.dart';

class ComponentsSearch extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  void Function(String)? onSubmitted;
  ComponentsSearch({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: paddingMin,
        right: paddingMin,
        bottom: paddingMin,
        top: paddingMin / 2,
      ),
      child: TextField(
        style: GoogleFonts.poppins(),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(paddingMin),
          prefixIcon: IconTheme(
            data: IconThemeData(color: Colors.grey.shade300),
            child: LineIcon.search(),
          ),
          hintText: "Search Menu",
          border: kInputBorder,
          errorBorder: kInputBorder,
          focusedBorder: kInputBorder,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
