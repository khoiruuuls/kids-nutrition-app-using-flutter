// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

class KidHeading extends StatefulWidget {
  final String docId;

  KidHeading({
    required this.docId,
    super.key,
  });

  @override
  State<KidHeading> createState() => _KidHeadingState();
}

class _KidHeadingState extends State<KidHeading> {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: firestoreService.getKidData(widget.docId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final data = snapshot.data!;

          final name = data['name'];
          final nik = data['nik'];

          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingMin / 2,
                vertical: paddingMin / 2,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade300,
                    radius: 40.0,
                    child: Icon(
                      Icons.person,
                      color: Colors.grey.shade100,
                      size: 40.0,
                    ),
                  ),
                  SizedBox(width: paddingMin * 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: paddingMin / 2),
                      Text(
                        nik,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
