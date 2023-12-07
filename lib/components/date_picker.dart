// date_picker.dart

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Future<DateTime?> selectDate(
  BuildContext context,
  DateTime selectedDate,
) async {
  return await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1000),
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.blue, // highlight color
          colorScheme: ColorScheme.light(primary: Colors.blue),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );
}
