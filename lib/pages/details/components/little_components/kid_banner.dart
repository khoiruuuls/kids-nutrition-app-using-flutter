// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import '../../../../main.dart';

class KidBanner extends StatelessWidget {
  final String text;
  const KidBanner({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(paddingMin / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300, // Shadow color
            blurRadius: 4, // Spread of the shadow
            offset: Offset(0, 2), // Shadow offset (x, y)
          ),
        ],
      ),
    );
  }
}
