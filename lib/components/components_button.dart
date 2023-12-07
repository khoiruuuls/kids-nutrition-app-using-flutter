// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../../../config/config_size.dart';

class ComponentsButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const ComponentsButton({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ConfigColor.darkBlue,
          borderRadius: BorderRadius.circular(paddingMin),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: paddingMin * 4,
          vertical: paddingMin,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: paddingMin,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
