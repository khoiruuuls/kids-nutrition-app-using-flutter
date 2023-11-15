// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../details/components/kid_nav.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  // String userName = "Not Found";
  // String userRole = "Not Found";
  // @override
  // void initState() {
  //   super.initState();

  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final userRef = FirebaseFirestore.instance
  //         .collection('users')
  //         .where("email", isEqualTo: user.email);

  //     userRef.get().then((querySnapshot) {
  //       if (querySnapshot.docs.isNotEmpty) {
  //         final userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
  //         setState(() {
  //           userName = userData['name'] ?? userName;
  //           userRole = userData['role'] ?? userRole;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email!)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              KidNav(
                textTitle: "Homepage",
                docId: "",
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: paddingMin * 3 / 2,
                    left: paddingMin * 3 / 2,
                    bottom: paddingMin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 40.0,
                            child: Icon(
                              Icons.person,
                              color: Colors.black45,
                              size: 40.0,
                            ),
                          ),
                          SizedBox(width: paddingMin * 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat datang,",
                              ),
                              SizedBox(height: paddingMin * 1 / 4),
                              Text(
                                userData["name"],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: paddingMin * 3 / 4),
                              Text(
                                userData["role"],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Text("No Data . . ");
        }
      },
    );
  }
}
