// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';
import 'package:flutter/services.dart';

class InputKids extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;
  final String? docId;
  final int maxLength;
  final bool isNumeric;
  const InputKids({
    this.isNumeric = false,
    required this.maxLength,
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
    List<TextInputFormatter> inputFormatters = [];

    // Choose formatters based on the isNumeric flag
    if (isNumeric) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
      ];
    }

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                maxLength: maxLength,
                inputFormatters: inputFormatters,
                keyboardType:
                    isNumeric ? TextInputType.number : TextInputType.text,
              ),
            ),
          ),
        )
      ],
    );
  }
}
