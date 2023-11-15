// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../main.dart';

class ComponentsButton extends StatelessWidget {
  final Function()? onTap;
  final Color? bgColor;
  final String text;

  const ComponentsButton({
    super.key,
    this.bgColor,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(paddingMin * 2),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: paddingMin * 4,
          vertical: paddingMin,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.blue.shade300, //conditional
            ),
          ),
        ),
      ),
    );
  }
}
