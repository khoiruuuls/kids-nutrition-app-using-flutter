// ignore_for_file: file_names, prefer_const_constructors, unnecessary_cast, unrelated_type_equality_checks, avoid_print, use_build_context_synchronously, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/auth_page/role_validation_page.dart';
import 'package:kids_nutrition_app/pages/recipe_page/recipe_page.dart';
import 'package:kids_nutrition_app/pages/role_kids/role_kids_page.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RoleValidationPage(id: snapshot.data!.uid);
          } else {
            print("Navigating to SignInPage() - No user data");
            return SignInPage();
          }
        },
      ),
    );
  }
}
