// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/config/config_void.dart';
import 'package:line_icons/line_icon.dart';

import '../../config/config_color.dart';
import '../../config/config_size.dart';
import '../auth_page/auth_page.dart';

class ProfileBanner extends StatelessWidget {
  ProfileBanner({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    logoutField() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Apakah anda yakin ingin log out ?",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Tidak",
                  style: GoogleFonts.poppins(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await FirebaseAuth.instance.signOut();
                  navigateToPage(context, AuthPage());
                },
                child: Text(
                  "Ya",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          );
        },
      );
    }

    print(currentUser);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(paddingMin),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: paddingMin * 3.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(paddingMin),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingMin),
                          child: Center(
                            child: Text(
                              "Profile Page",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: paddingMin),
                  GestureDetector(
                    onTap: () {
                      logoutField();
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: [
                          Container(
                            height: paddingMin * 3.5,
                            width: paddingMin * 3.5,
                            decoration: BoxDecoration(
                              color: ConfigColor.darkBlue,
                              borderRadius: BorderRadius.circular(paddingMin),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: LineIcon.alternateSignOut(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text("no data");
          }
        });
  }
}
