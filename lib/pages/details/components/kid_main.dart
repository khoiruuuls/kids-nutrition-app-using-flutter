// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/details/components/little_components/kid_banner.dart';

import '../../../main.dart';
import 'kid_heading.dart';
import 'kid_history.dart';
import 'kid_information.dart';
import 'kid_target.dart';

class KidMain extends StatelessWidget {
  final String docId;
  const KidMain({
    required this.docId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(paddingMin),
              child: Column(
                children: [
                  KidHeading(
                    docId: docId,
                  ),
                  SizedBox(height: paddingMin),
                  KidInformation(
                    docId: docId,
                    titleText: "Informasi",
                  ),
                  SizedBox(height: paddingMin),
                  KidTarget(userId: docId),
                  SizedBox(height: paddingMin),
                  KidBanner(text: "Riwayat Makan"),
                  SizedBox(height: paddingMin),
                  KidHistory(userId: docId),
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
