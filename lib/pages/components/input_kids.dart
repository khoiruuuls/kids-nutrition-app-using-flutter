// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';

class InputKids extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;
  final String? docId;
  const InputKids({
    this.docId,
    this.controller,
    required this.hintText,
    required this.text,
    super.key,
  });

  Future<Map<String, dynamic>> getKidData(String docId) async {
    final DocumentSnapshot kidDocument =
        await FirebaseFirestore.instance.collection('kids').doc(docId).get();
    return kidDocument.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(paddingMin / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(paddingMin / 2),
                ),
                hintText: hintText,
                contentPadding: EdgeInsets.symmetric(
                  vertical: paddingMin * 5 / 4,
                  horizontal: paddingMin * 3 / 2,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
