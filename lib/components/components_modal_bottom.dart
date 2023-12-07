// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../../config/config_size.dart';

void showCustomModalBottomSheet(BuildContext context, String message) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(paddingMin),
        topRight: Radius.circular(paddingMin),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    },
  );
  Future.delayed(Duration(milliseconds: 1000), () {
    Navigator.of(context).pop();
  });
}
