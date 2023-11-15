import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // google sign in
  Future<UserCredential> signInWithGoogle() async {
    // Begin interactive sign process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

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
    await FirebaseFirestore.instance.collection("Users").doc(userEmail).set({
      'name': userName,
      'role': "empty role . . .",
      'phone': "empty phone . . .",
      'bio': "empty bio . . .",
    });

    // Return the user credential
    return userCredential;
  }
}
