// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, prefer_is_empty

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/components_text_box.dart';
import 'package:kids_nutrition_app/components/components_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import '../../config/config_color.dart';
import '../../config/config_size.dart';
import 'profile_banner.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadPhoto() async {
    final path = "${currentUser.uid}.jpg";
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final link =
        "https://firebasestorage.googleapis.com/v0/b/kids-nutrition-app.appspot.com/o/${currentUser.uid}.jpg?alt=media&token=814963ac-79a7-46b9-b411-a2f9578d080f";

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({
      'photo': link,
    });
  }

  Future selectPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Widget buildProgress() => StreamBuilder(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: paddingMin * 0.5,
                  backgroundColor: Colors.white,
                  color: ConfigColor.darkBlue,
                  borderRadius: BorderRadius.circular(paddingMin),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${(100 * progress).roundToDouble()} %",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox(
              height: paddingMin,
            );
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);

    final currentUser = FirebaseAuth.instance.currentUser!;
    final usersCollection = FirebaseFirestore.instance.collection("users");

    Future<void> editField(String field) async {
      String newValue = "";

      await showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: paddingMin * 0.5),
                    child: Text(
                      "Edit $field",
                      style: GoogleFonts.poppins(
                        fontSize: paddingMin,
                        color: ConfigColor.darkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: kInputBorder,
                    errorBorder: kInputBorder,
                    focusedBorder: sInputBorder,
                    enabledBorder: kInputBorder,
                    hintText: "Enter new $field",
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: paddingMin * 5 / 4,
                      horizontal: paddingMin * 3 / 2,
                    ),
                    counterText: '',
                  ),
                  onChanged: (value) {
                    newValue = value;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          color: ConfigColor.darkBlue,
                          fontSize: paddingMin,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(newValue);
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                          fontSize: paddingMin,
                          color: ConfigColor.darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // Update firestore
      if (newValue.trim().length > 0) {
        // Only update Firestore if a valid new value is provided
        await usersCollection.doc(currentUser.uid).update({field: newValue});
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ProfileBanner(),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  // get user data
                  if (snapshot.hasData) {
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: paddingMin),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(paddingMin),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 24,
                                    spreadRadius: 0,
                                    offset: Offset(0, 3),
                                    color: Colors.grey.shade200,
                                  )
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(paddingMin),
                              child: pickedFile == null
                                  ? Image.network(
                                      userData['photo'],
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(pickedFile!.path!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(height: paddingMin),
                          buildProgress(),
                          SizedBox(height: paddingMin),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ComponentsButton(
                                onTap: selectPhoto,
                                text: "Select",
                              ),
                              ComponentsButton(
                                onTap: uploadPhoto,
                                text: "Upload",
                              ),
                            ],
                          ),
                          SizedBox(height: paddingMin),
                          ComponentsTextBox(
                            sectionName: "Name",
                            text: userData['name'],
                            onPressed: () => editField("name"),
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
                          SizedBox(height: paddingMin * 2),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: paddingMin * 5),
          ],
        ),
      ),
    );
  }
}
