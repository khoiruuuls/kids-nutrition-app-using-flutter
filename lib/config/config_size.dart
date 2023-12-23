// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

import 'config_color.dart';

class ConfigSize {
  static MediaQueryData? mediaQueryData;
  static double? screenHeight;
  static double? screenWidth;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}

const double paddingMin = 16;
const double fontHeading = 20;

final kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(paddingMin),
  borderSide: BorderSide(
    color: Colors.grey.shade300,
  ),
);

final sInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(paddingMin),
  borderSide: const BorderSide(
    color: ConfigColor.darkBlue,
  ),
);
