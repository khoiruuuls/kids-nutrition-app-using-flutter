// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_square_tile.dart';
import 'package:kids_nutrition_app/pages/auth/auth_service.dart';

import '../../components/component_button.dart';
import '../../components/component_input.dart';
import '../auth/sign_up_page.dart';
import '../first_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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

    void signUserIn() async {
      // Menampilkan dialog loading saat proses masuk berlangsung.
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        // Melakukan masuk pengguna menggunakan Firebase Authentication.
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        ); // Menutup dialog loading.
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FirstPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(
            context); // Menutup dialog loading jika terjadi kesalahan.
        // Menampilkan pesan kesalahan yang diterima dari Firebase Authentication.
        showErrorMessage(e.code);
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log In",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              ComponentsInput(
                controller: emailController,
                hintText: "Masukan Email kamu",
                obsecureText: false,
              ),
              ComponentsInput(
                controller: passwordController,
                hintText: "Masukan Password kamu",
                obsecureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              ComponentsButton(
                text: "Login",
                onTap: signUserIn,
              ),
              SizedBox(height: 40),
              Text(
                "Or login with",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 25,
              ),
              ComponentsSquareTile(
                onTap: () async {
                  try {
                    await AuthService().signInWithGoogle();
                    // The sign-in with Google was successful, you can add any additional logic here
                  } catch (e) {
                    // Handle errors or exceptions if the sign-in fails
                    print('Error signing in with Google: $e');
                  }
                },
                imagePath: 'assets/images/google-fill.png',
              ),
              SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Doesn't have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: "Create one",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
