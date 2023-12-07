// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/components_back.dart';
import '../../components/components_text_box.dart';
import '../../config/config_size.dart';

class EditProfilePage extends StatefulWidget {
  final String email;

  const EditProfilePage({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit " + field,
          style: TextStyle(color: Colors.blue.shade300),
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),

          // save
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text("Save"),
          ),
        ],
      ),
    );

    // update firestore
    if (newValue.trim().length >= 0) {
      // only update the fire store
      await usersCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                ComponentsBack(
                  textTitle: "Edit Profile",
                ),
                SizedBox(height: 50),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(paddingMin),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(paddingMin),
                    child: Image.network(
                      'https://getillustrations.b-cdn.net//photos/pack/3d-avatar-male_lg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'you are login as ${currentUser.email!}',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: paddingMin * 2),
                ComponentsTextBox(
                  sectionName: "Name",
                  text: userData['name'],
                  onPressed: () => editField("name"),
                ),
                SizedBox(height: paddingMin),
                ComponentsTextBox(
                  sectionName: "Role",
                  text: userData['role'],
                  onPressed: () => editField("role"),
                ),
                SizedBox(height: paddingMin),
                ComponentsTextBox(
                  sectionName: "Phone",
                  text: userData['phone'],
                  onPressed: () => editField("phone"),
                ),
                SizedBox(height: paddingMin),
                ComponentsTextBox(
                  sectionName: "Bio",
                  text: userData['bio'],
                  onPressed: () => editField("bio"),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
