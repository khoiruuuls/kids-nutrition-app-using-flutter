// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components/components/input_kids.dart';
import 'package:kids_nutrition_app/components/components_category_role.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/config/config_size.dart';
import 'package:kids_nutrition_app/pages/auth_page/email_verify_page.dart';
import 'package:kids_nutrition_app/pages/auth_page/role_validation_page.dart';
import '../../components/components_button.dart';
import '../../components/components_modal_bottom.dart';
import '../../components/components_select_gender.dart';
import '../../components/list_helper/component_list_helper.dart';
import '../../components/text_editing_controller.dart';
import '../auth_page/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int selectedCategoryIndex = 0;
  int selectedGenderIndex = 0;
  ComponentsListHelper componentsListHelper = ComponentsListHelper();
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    void signUserUp() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userController.emailController.text,
          password: userController.passwordController.text,
        );

        FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set(
          {
            'uid': auth.currentUser!.uid,
            'name': userController.nameController.text,
            'email': userController.emailController.text,
            'role': componentsListHelper.role[selectedCategoryIndex],
            'gender': componentsListHelper.gender[selectedGenderIndex],
            'weight': 0.0,
            'height': 0.0,
            'photo': 'https://bit.ly/kids-nutrition-app-pp',
            'bio': "No data record .",
            'phone': "No data record .",
            'nik': "No data record .",
            'dateBirth': "No data record .",
            'placeBirth': "No data record .",
            'timestamp': Timestamp.now(),
          },
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => RoleValidationPage(id: auth.currentUser!.uid),
            builder: (context) => EmailVerifyPage(id: auth.currentUser!.uid),
          ),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == "email-already-in-use") {
          showCustomModalBottomSheet(
            context,
            "Email sudah digunakan",
          );
        } else if (e.code == "invalid-email") {
          showCustomModalBottomSheet(
            context,
            "Format email salah",
          );
        } else if (e.code == "channel-error") {
          showCustomModalBottomSheet(
            context,
            "Email dan password harus diisi",
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
                SizedBox(height: paddingMin * 3),
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: ConfigColor.darkBlue,
                  ),
                ),
                SizedBox(height: paddingMin * 2),
                InputKids(
                  obscureText: false,
                  maxLength: 23,
                  hintText: "Masukan Nama kamu",
                  controller: userController.nameController,
                  text: "Nama Lengkap",
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
                InputKids(
                  obscureText: true,
                  hintText: "Masukan Password kamu",
                  isAuth: true,
                  controller: userController.passwordController,
                  text: "Password",
                ),
                SizedBox(height: paddingMin),
                ComponentsSelectGender(
                  onGenderSelected: (index) {
                    setState(() {
                      selectedGenderIndex = index;
                    });
                  },
                ),
                ComponentsCategoryRole(
                  onCategorySelected: (index) {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),
                SizedBox(height: paddingMin),
                ComponentsButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                SizedBox(height: paddingMin * 2),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Have already account? ",
                        style: GoogleFonts.poppins(color: ConfigColor.darkBlue),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: GoogleFonts.poppins(
                          color: ConfigColor.darkBlue,
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
