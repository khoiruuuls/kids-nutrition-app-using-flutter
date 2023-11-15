// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, unnecessary_cast, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';
import 'package:kids_nutrition_app/pages/auth/edit_profile_page.dart';

import '../components/component_little_card.dart';
import 'auth/auth_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email!)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(paddingMin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 70.0,
                      child: Icon(
                        Icons.person,
                        color: Colors.black45,
                        size: 70.0,
                      ),
                    ),
                    SizedBox(height: paddingMin),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              userData['name'],
                              style: TextStyle(
                                fontSize: paddingMin + 4,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: paddingMin),
                            Text(
                              userData['role'],
                              style: TextStyle(
                                fontSize: paddingMin,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: paddingMin / 2),
                            Text(
                              currentUser.email!,
                              style: TextStyle(
                                fontSize: paddingMin,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          ComponentsLittleCard(
                            text: "Edit User",
                            icon: Icons.edit_document,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(
                                    email: currentUser.email!,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: paddingMin),
                          ComponentsLittleCard(
                            text: "Log out",
                            icon: Icons.logout,
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuthPage()));
                              } catch (e) {
                                // Handle sign-out errors if necessary
                                print('Sign-out error: $e');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text("No data . . ");
          }
        },
      ),
    );
  }
}
