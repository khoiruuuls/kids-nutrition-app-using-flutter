// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components/components/input_kids.dart';
import 'package:kids_nutrition_app/components/components_square_tile.dart';
import 'package:kids_nutrition_app/components/text_editing_controller.dart';
import 'package:kids_nutrition_app/config/config_class.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/config/config_void.dart';
import 'package:kids_nutrition_app/services/auth_service.dart';

import '../../components/components_button.dart';
import '../../components/components_input.dart';
import '../../components/components_modal_bottom.dart';
import '../../config/config_size.dart';
import '../auth_page/sign_up_page.dart';
import 'forgot_password_page.dart';
import 'role_validation_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserController userController = UserController();

    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          );
        },
      );
    }

    void signUserIn() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userController.emailController.text,
          password: userController.passwordController.text,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoleValidationPage(id: auth.currentUser!.uid),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "INVALID_LOGIN_CREDENTIALS") {
          showCustomModalBottomSheet(
            context,
            "Email or password wrong",
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: paddingMin * 4),
                Text(
                  "Log In",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                InputKids(
                  obscureText: false,
                  hintText: "Masukan Email kamu",
                  isAuth: true,
                  controller: userController.emailController,
                  text: "Email",
                ),
                SizedBox(height: paddingMin),
                InputKids(
                  obscureText: true,
                  hintText: "Masukan Password kamu",
                  isAuth: true,
                  controller: userController.passwordController,
                  text: "Password",
                ),
                SizedBox(height: paddingMin * 2),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: paddingMin),
                    child: GestureDetector(
                      onTap: () {
                        navigateToPage(context, ForgotPasswordPage());
                      },
                      child: Text(
                        "Forgot password ?",
                        style: GoogleFonts.poppins(
                          fontSize: paddingMin * 0.85,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: paddingMin * 2),
                ComponentsButton(
                  text: "Login",
                  onTap: signUserIn,
                ),
                SizedBox(height: paddingMin * 2),
                LineDeviderHorizontal(
                  widthLine: paddingMin,
                  chooseColor: ConfigColor.darkBlue,
                ),
                SizedBox(height: paddingMin * 2),
                ComponentsSquareTile(
                  onTap: () async {
                    try {
                      await AuthService().signInWithGoogle();
                    } catch (e) {
                      print('Error signing in with Google: $e');
                    }
                  },
                  imagePath: 'assets/images/google-fill.png',
                ),
                SizedBox(
                  height: paddingMin * 2,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Doesn't have an account? ",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: paddingMin * 0.85,
                        ),
                      ),
                      TextSpan(
                        text: "Create one",
                        style: GoogleFonts.poppins(
                          fontSize: paddingMin * 0.85,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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
                SizedBox(height: paddingMin * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
