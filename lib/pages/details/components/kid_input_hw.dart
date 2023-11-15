// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';
import 'package:kids_nutrition_app/pages/details/components/little_components/kid_hw.dart';

class KidInputHw extends StatelessWidget {
  final TextEditingController? controllerWeight;
  final TextEditingController? controllerHeight;
  final String? hintTextHeight;
  final String? hintTextWeight;
  final String? controller;
  const KidInputHw({
    this.hintTextHeight,
    this.hintTextWeight,
    this.controllerHeight,
    this.controllerWeight,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: paddingMin,
          vertical: paddingMin * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KidHw(
                  hintText: hintTextHeight,
                  textTitle: "Tinggi badan",
                  textMeasure: "cm",
                  controller: controllerHeight,
                ),
                KidHw(
                  hintText: hintTextWeight,
                  textTitle: "Berat badan",
                  textMeasure: "kg",
                  controller: controllerWeight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
