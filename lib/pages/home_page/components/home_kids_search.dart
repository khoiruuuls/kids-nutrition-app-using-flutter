// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../../../config/config_size.dart';

class HomeKidsSearch extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  HomeKidsSearch({
    required this.searchController,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingMin,
      ),
      child: TextField(
        style: GoogleFonts.poppins(),
        controller: searchController,
        onChanged: (_) => onSearch(), // Call onSearch when the text changes
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(paddingMin),
          prefixIcon: IconTheme(
            data: IconThemeData(color: Colors.grey.shade300),
            child: LineIcon.search(),
          ),
          hintText: "Search Kids",
          border: kInputBorder,
          errorBorder: kInputBorder,
          focusedBorder: kInputBorder,
        ),
      ),
    );
  }
}
