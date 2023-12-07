// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';
import '../../components/components_little_card.dart';
import '../role_kids/role_kids_page.dart';
import 'auth_page.dart';

class RoleValidationPage extends StatelessWidget {
  final String id;

  const RoleValidationPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
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
            final dataRole = (data as Map<String, dynamic>)['role'];

            return dataRole == "Anak Panti"
                ? RoleKidsPage(id: id)
                : FirstPage();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Role data doesn't exist."),
              SizedBox(height: 20),
              ComponentsLittleCard(
                text: "Log out",
                icon: Icons.logout,
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthPage()));
                  } catch (e) {
                    // Handle sign-out errors if necessary
                    print('Sign-out error: $e');
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
