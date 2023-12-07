// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable, unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components_title.dart';
import '../../components/components/components/list_kids_new.dart';

import '../../config/config_size.dart';
import '../../services/firestore.dart';
import 'chat_room_page.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final FirestoreService firestoreService = FirestoreService();
  final User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ComponentsTitle(textTitle: "Let's Make a Chat !"),
            SizedBox(height: paddingMin / 2),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where('role', isNotEqualTo: "Anak Panti")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    // Filter out the current user's data
                    documents = documents
                        .where((doc) => doc['uid'] != currentUser.uid)
                        .toList();

                    if (documents.isEmpty) {
                      return Center(
                        child: Text(
                          'No other users available',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              var data = documents[index].data()
                                  as Map<String, dynamic>;
                              var uid = data['uid'];
                              var name = data['name'];
                              var email = data['email'];
                              var role = data['role'];
                              var timestamp = data["timestamp"];
                              String formattedDate = DateFormat('dd MMMM yyyy')
                                  .format(timestamp.toDate());
                              String formattedTime = DateFormat('hh : mm')
                                  .format(timestamp.toDate());
                              return ListTile(
                                title: ListKidsNew(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatRoomPage(
                                          recieverUserID: uid,
                                          receiverUserEmail: email,
                                        ),
                                      ),
                                    );
                                  },
                                  id: uid,
                                  role: role,
                                  date: formattedDate,
                                  time: formattedTime,
                                  name: name,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 100),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No data records yet',
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
