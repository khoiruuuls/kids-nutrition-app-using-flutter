// ignore_for_file: file_names, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/auth/sign_in_page.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is login
          if (snapshot.hasData) {
            return FirstPage();
          }
          // login page
          else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
