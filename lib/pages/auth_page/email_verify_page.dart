// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously, avoid_print, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components_back.dart';
import 'package:kids_nutrition_app/components/components_button.dart';
import 'package:kids_nutrition_app/components/text_editing_controller.dart';
import 'package:kids_nutrition_app/config/config_size.dart';
import 'package:kids_nutrition_app/pages/auth_page/role_validation_page.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';

class EmailVerifyPage extends StatefulWidget {
  final String id;
  EmailVerifyPage({
    required this.id,
    super.key,
  });

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  bool isVerify = false;
  Timer? timer;
  UserController userController = UserController();

  @override
  void initState() {
    super.initState();

    isVerify = FirebaseAuth.instance.currentUser!.emailVerified;

    Future sendVerificationEmail() async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user?.sendEmailVerification();
      } on Exception catch (e) {
        print(e);
      }
    }

    Future checkVerifyEmail() async {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }

    if (!isVerify) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkVerifyEmail());
    }

    @override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) => isVerify
      ? RoleValidationPage(
          id: FirebaseAuth.instance.currentUser!.uid,
        )
      : Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ComponentsBack(textTitle: "Email Verification"),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: paddingMin * 1.5,
                        ),
                        child: Text(
                          "Please check your email and click on the provided link to activate your account.",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      SizedBox(height: paddingMin * 2),
                      ComponentsButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: "Back",
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
