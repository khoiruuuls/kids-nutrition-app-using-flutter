// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components/little_components/kid_banner.dart';

import '../../config/config_size.dart';
import 'kid_heading.dart';
import 'kid_history.dart';
import 'kid_information.dart';

class KidMain extends StatelessWidget {
  final String id;
  const KidMain({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(paddingMin),
              child: Column(
                children: [
                  KidHeading(id: id),
                  SizedBox(height: paddingMin),
                  KidInformation(id: id),
                  SizedBox(height: paddingMin),
                  KidBanner(text: "Riwayat Makan"),
                  SizedBox(height: paddingMin),
                  KidHistory(id: id),
                  SizedBox(height: paddingMin * 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
