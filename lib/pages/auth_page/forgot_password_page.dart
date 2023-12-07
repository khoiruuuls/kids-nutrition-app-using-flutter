// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously, avoid_print, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components_back.dart';
import 'package:kids_nutrition_app/components/components_button.dart';
import 'package:kids_nutrition_app/components/text_editing_controller.dart';
import 'package:kids_nutrition_app/config/config_size.dart';

import '../../components/components/components/input_kids.dart';
import '../../components/components_modal_bottom.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  UserController userController = UserController();

  @override
  void dispose() {
    userController.emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: userController.emailController.text.trim(),
      );
      showCustomModalBottomSheet(
        context,
        "Password reset link send, check your email",
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showCustomModalBottomSheet(
        context,
        e.message.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ComponentsBack(textTitle: "Reset Password"),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: paddingMin * 1.5,
                    ),
                    child: Text(
                      "Enter your email and we will send you password reset link",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  SizedBox(height: paddingMin),
                  InputKids(
                    obscureText: false,
                    hintText: "Masukan Email kamu",
                    isAuth: true,
                    controller: userController.emailController,
                    text: "Email",
                  ),
                  SizedBox(height: paddingMin),
                  ComponentsButton(
                    onTap: passwordReset,
                    text: "Reset Password",
                  ),
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
