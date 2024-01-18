// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kids_nutrition_app/components/components/components/input_kids.dart';
import 'package:kids_nutrition_app/components/components_square_tile.dart';
import 'package:kids_nutrition_app/components/text_editing_controller.dart';
import 'package:kids_nutrition_app/config/config_class.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/config/config_void.dart';

import '../../components/components_button.dart';
import '../../components/components_modal_bottom.dart';
import '../../config/config_size.dart';
import '../auth_page/sign_up_page.dart';
import 'forgot_password_page.dart';
import 'role_selection_page.dart';
import 'role_validation_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<UserCredential?> signInWithGoogle() async {
    // Begin interactive sign process
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final FirebaseAuth auth = FirebaseAuth.instance;

      // Check if the user canceled the sign-in
      if (googleUser == null) {
        return Future.error("Google sign-in canceled");
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Store user data in Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        // Access the "role" field in the document
        var role = snapshot.get('role');

        if (role != null) {
          // If the "role" field exists, navigate to RoleValidationPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RoleValidationPage(id: auth.currentUser!.uid),
            ),
          );
        } else {
          // If the "role" field doesn't exist, navigate to RoleSelectionPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoleSelectionPage(),
            ),
          );
        }
        // Return the user credential
        return userCredential;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserController userController = UserController();

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
                      await signInWithGoogle();
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
