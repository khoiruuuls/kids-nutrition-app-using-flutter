// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable, unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_title.dart';
import '../../components/components/components/list_kids_new.dart';

import '../../services/firestore.dart';
import 'chat_room_page.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  FirestoreService firestoreService = FirestoreService();

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: buildUserList(context),
      ),
    );
  }

  Widget buildUserList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text(""));
        }
        return Column(
          children: [
            ComponentsTitle(textTitle: "Let\'s Make a Chat !"),
            Expanded(
              child: ListView(
                children: snapshot.data!.docs
                    .map<Widget>((doc) => buildUserListItem(context, doc))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildUserListItem(BuildContext context, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (currentUser.email != data["email"]) {
      return ListTile(
        title: ListKidsNew(
          time: "",
          date: "",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoomPage(
                  receiverUserEmail: data["email"],
                  recieverUserID: data['uid'],
                ),
              ),
            );
          },
          name: data['email'],
          id: '',
        ),
      );
    }
    return SizedBox
        .shrink(); // Return an empty widget if the condition is not met.
  }
}
