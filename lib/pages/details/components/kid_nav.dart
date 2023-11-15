// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/details/kid_edit_form.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../../../main.dart';
import '../../first_page.dart';

class KidNav extends StatelessWidget {
  final String textTitle;
  final IconData? editIcon;
  final IconData? deleteIcon;
  final String docId;
  const KidNav({
    required this.docId,
    this.editIcon,
    this.deleteIcon,
    required this.textTitle,
    super.key,
  });

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(paddingMin),
          topRight: Radius.circular(paddingMin),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        // Display the modal bottom sheet content
        return Container(
          height: 100,
          child: Center(
            child: Text(
              "Berhasil dihapus",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );

    // Close the modal bottom sheet after 1 second
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return Container(
      decoration: BoxDecoration(color: Colors.blue.shade100),
      child: Padding(
        padding: const EdgeInsets.all(paddingMin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: fontHeading,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => KidEditForm(
                              docId: docId,
                            )),
                      ),
                    ),
                  },
                  child: Icon(editIcon),
                ),
                SizedBox(width: paddingMin),
                GestureDetector(
                  onTap: () async {
                    await firestoreService.deleteKid(docId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstPage(),
                      ),
                    );
                    _showModalBottomSheet(context);
                  },
                  child: Icon(deleteIcon),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
