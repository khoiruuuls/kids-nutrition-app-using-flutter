// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_back.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';

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
            ComponentsBack(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FirstPage(),
                    ),
                  );
                },
                textTitle: "Kids Data",
                id: id),
            KidMain(id: id),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 8,
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
