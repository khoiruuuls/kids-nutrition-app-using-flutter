// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import '../../../config/config_size.dart';
import '../../details/kid_page.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("kids")
          .doc(currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: paddingMin * 2, vertical: paddingMin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello, Good Morning ✌️",
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          data['name'],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: paddingMin,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KidPage(id: currentUser.uid),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          "https://getillustrations.b-cdn.net//photos/pack/3d-avatar-male_lg.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingMin,
                ),
                child: TextField(
                  style: GoogleFonts.poppins(),
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(paddingMin),
                    prefixIcon: IconTheme(
                      data: IconThemeData(color: Colors.grey.shade300),
                      child: LineIcon.search(),
                    ),
                    hintText: "Search Kids",
                    border: kInputBorder,
                    errorBorder: kInputBorder,
                    focusedBorder: kInputBorder,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Text("No Data . . ");
        }
      },
    );
  }
}
