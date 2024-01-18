import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/auth_page/auth_page.dart';

import '../../components/components_little_card.dart';

class TestMessageNotification extends StatelessWidget {
  const TestMessageNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Message'),
      ),
      body: ComponentsLittleCard(
        text: "Log out",
        icon: Icons.logout,
        onTap: () async {
          try {
            await FirebaseAuth.instance.signOut();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AuthPage()));
          } catch (e) {
            // Handle sign-out errors if necessary
            print('Sign-out error: $e');
          }
        },
      ),
    );
  }
}
