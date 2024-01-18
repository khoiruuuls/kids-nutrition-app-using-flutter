import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kids_nutrition_app/components/components_button.dart';
import 'package:kids_nutrition_app/config/config_size.dart';

import '../../components/components_category_role.dart';
import '../../components/list_helper/component_list_helper.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  int selectedCategoryIndex = 0;
  ComponentsListHelper componentsListHelper = ComponentsListHelper();

  Future<UserCredential> signInWithGoogle() async {
    // Begin interactive sign process
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

    // Access the user's email
    String userEmail = userCredential.user!.email!;
    String userName = userCredential.user!.displayName!;

    // Store user data in Firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set({
      'name': userName,
      'uid': auth.currentUser!.uid,
      'email': userEmail,
      'role': componentsListHelper.role[selectedCategoryIndex],
      'gender': "Laki Laki",
      'weight': 0.0,
      'height': 0.0,
      'photo': auth.currentUser!.photoURL,
      'bio': "No data record .",
      'phone': "No data record .",
      'nik': "No data record .",
      'dateBirth': "No data record .",
      'placeBirth': "No data record .",
      'timestamp': Timestamp.now(),
    });

    // Return the user credential
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ComponentsCategoryRole(
                    onCategorySelected: (index) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: paddingMin),
                  ComponentsButton(
                    onTap: signInWithGoogle,
                    text: "Buat Akun",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
