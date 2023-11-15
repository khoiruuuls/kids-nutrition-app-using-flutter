// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../main.dart';

class ComponentsInput extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;

  const ComponentsInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          obscureText: obsecureText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(paddingMin)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(paddingMin),
            ),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: paddingMin * 5 / 4,
              horizontal: paddingMin * 3 / 2,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
