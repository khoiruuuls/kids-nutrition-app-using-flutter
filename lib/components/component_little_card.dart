// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../main.dart';

class ComponentsLittleCard extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function()? onTap;
  const ComponentsLittleCard({this.onTap, this.icon, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(paddingMin),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              blurRadius: 4, // Spread of the shadow
              offset: Offset(2, 2), // Shadow offset (x, y)
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingMin * 2,
              vertical: paddingMin * 3 / 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text ?? "example only",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(icon ?? Icons.arrow_forward_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
