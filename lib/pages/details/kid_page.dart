// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_back.dart';

import '../../components/components/kid_floating_button.dart';
import '../../components/components/kid_main.dart';

class KidPage extends StatelessWidget {
  final String id;

  const KidPage({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ComponentsBack(textTitle: "Kids Data", id: id),
            KidMain(id: id),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16, // Adjust the position as needed
            right: 8, // Adjust the position as needed
            child: KidFloatingButton(
              id: id,
              icon: Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
