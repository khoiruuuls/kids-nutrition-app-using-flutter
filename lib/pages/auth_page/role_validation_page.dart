// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_void.dart';
import 'package:kids_nutrition_app/pages/auth_page/auth_page.dart';
import 'package:kids_nutrition_app/pages/auth_page/role_selection_page.dart';
import '../first_page.dart';
import '../role_kids/role_kids_page.dart';

class RoleValidationPage extends StatelessWidget {
  final String id;

  const RoleValidationPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("users").doc(id).snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (userSnapshot.hasError) {
            return Text('Error: ${userSnapshot.error}');
          }

          var data = userSnapshot.data?.data();

          if (data != null) {
            final dataRole = data['role'];

            return dataRole == "Anak Panti"
                ? RoleKidsPage(id: id)
                : FirstPage();
          }

          return RoleSelectionPage();
        },
      ),
    );
  }
}
