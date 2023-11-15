// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../../../main.dart';

class KidInformation extends StatefulWidget {
  final String titleText;
  final String? descriptionText;
  final String docId;

  const KidInformation({
    required this.docId,
    required this.titleText,
    this.descriptionText,
    super.key,
  });

  @override
  State<KidInformation> createState() => _KidInformationState();
}

class _KidInformationState extends State<KidInformation> {
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

          final gender = data['gender'];
          final height = data['height'];
          final weight = data['weight'];
          final dateBirth = data['dateBirth'];
          final placeBirth = data['placeBirth'];

          return Container(
            padding: const EdgeInsets.all(paddingMin),
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(gender),
                    SizedBox(height: paddingMin / 2),
                    Text("$placeBirth, $dateBirth"),
                    SizedBox(height: paddingMin / 2),
                    Text("Berat badan : $weight kg, Tinggi badan : $height cm"),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
