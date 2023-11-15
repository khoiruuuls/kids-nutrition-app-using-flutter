// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';
import '../../components/component_button.dart';
import '../../components/component_input.dart';
import '../auth/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final roleController = TextEditingController();

    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );
    }

    void signUserUp() async {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'role': roleController.text,
          'name': nameController.text,
          'phone': "empty phone . . .",
          'bio': "empty bio . . .",
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FirstPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Menutup dialog jika terjadi kesalahan.
        Navigator.pop(context);
        // Menampilkan pesan kesalahan yang diterima dari Firebase Authentication.
        showErrorMessage(e.code);
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                ComponentsInput(
                  controller: nameController,
                  hintText: "Masukan Nama kamu",
                  obsecureText: false,
                ),
                ComponentsInput(
                  controller: emailController,
                  hintText: "Masukan Email kamu",
                  obsecureText: false,
                ),
                ComponentsInput(
                  controller: roleController,
                  hintText: "Masukan Role kamu",
                  obsecureText: false,
                ),
                ComponentsInput(
                  controller: passwordController,
                  hintText: "Masukan Password kamu",
                  obsecureText: true,
                ),
                SizedBox(
                  height: 15,
                ),
                ComponentsButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Have already account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignInPage()));
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
