// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../config/config_size.dart';

class KidFood extends StatelessWidget {
  final String foodName;
  const KidFood({required this.foodName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(paddingMin / 2),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(paddingMin - 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(foodName), // call name nutrition field here
                SizedBox(height: paddingMin / 3),
                Text("1 piring, Nasi Sayur Sop"),
              ],
            ),
            SizedBox(width: paddingMin),
            Text("90")
          ],
        ),
      ),
    );
  }
}
