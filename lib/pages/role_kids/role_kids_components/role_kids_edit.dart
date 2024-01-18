// ignore_for_file: curly_braces_in_flow_control_structures, unused_element, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components_no_data.dart';
import 'package:kids_nutrition_app/components/components_select_gender.dart';

import '../../../components/components/components/input_kids.dart';
import '../../../components/components/kid_input_hw.dart';
import '../../../components/components_back.dart';
import '../../../components/components_button.dart';
import '../../../components/components_modal_bottom.dart';
import '../../../components/date_picker.dart';
import '../../../components/list_helper/component_list_helper.dart';
import '../../../components/text_editing_controller.dart';
import '../../../config/config_color.dart';
import '../../../config/config_size.dart';
import '../../../services/firestore.dart';
import '../../../services/kid_services.dart';

class RoleKidsEdit extends StatefulWidget {
  final String id;
  const RoleKidsEdit({
    required this.id,
    super.key,
  });

  @override
  State<RoleKidsEdit> createState() => _RoleKidsEditState();
}

class _RoleKidsEditState extends State<RoleKidsEdit> {
  int selectedGenderIndex = 0;
  DateTime selectedDate = DateTime.now();

  KidTextControllers kids = KidTextControllers();

  ComponentsListHelper componentsListHelper = ComponentsListHelper();

  FirestoreService firestoreService = FirestoreService();

  void _showModalBottomSheet(BuildContext context, String message) {
    showCustomModalBottomSheet(context, message);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await selectDate(context, selectedDate);

    if (picked != null && picked != selectedDate)
      setState(
        () {
          selectedDate = picked;
        },
      );
  }

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
    String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ComponentsBack(
              textTitle: "Kids Edit",
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(currentUser.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final userData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingMin),
                            child: Column(
                              children: [
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(paddingMin),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3),
                                          color: Colors.grey.shade200,
                                        )
                                      ]),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(paddingMin),
                                    child: pickedFile == null
                                        ? Image.network(
                                            userData['photo'],
                                            width: double.infinity,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              ],
                            ),
                          );
                        } else {
                          return ComponentsNoData();
                        }
                      },
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingMin),
                          child: Column(
                            children: [
                              SizedBox(height: paddingMin * 1.55),
                              InputKids(
                                maxLength: 23,
                                id: widget.id,
                                text: "Nama Lengkap",
                                hintText: "Masukan Nama Lengkap",
                                controller: kids.textNameController,
                                obscureText: false,
                              ),
                              SizedBox(height: paddingMin),
                              InputKids(
                                maxLength: 16,
                                id: widget.id,
                                text: "NIK",
                                hintText: "Masukan NIK",
                                isNumeric: true,
                                controller: kids.textNikController,
                                obscureText: false,
                              ),
                              SizedBox(height: paddingMin),
                              ComponentsSelectGender(
                                onGenderSelected: (index) {
                                  if (selectedGenderIndex != 1) {
                                    setState(() {
                                      selectedGenderIndex = index;
                                    });
                                  }
                                },
                              ),
                              InputKids(
                                maxLength: 20,
                                id: widget.id,
                                text: "Tempat lahir",
                                hintText: "Masukan Tempat Lahir",
                                controller: kids.textPlaceBirthController,
                                obscureText: false,
                              ),
                              SizedBox(height: paddingMin),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: paddingMin + 5),
                                    child: Text(
                                      "Tanggal lahir",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: paddingMin),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: paddingMin - 5),
                                    child: GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: paddingMin * 5 / 4,
                                          horizontal: paddingMin * 3 / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(paddingMin),
                                        ),
                                        width: double.infinity,
                                        child: Text(
                                          formattedDate,
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              KidInputHw(
                                hintTextHeight: 50,
                                hintTextWeight: 50,
                                controllerHeight: kids.textHeightController,
                                controllerWeight: kids.textWeightController,
                              ),
                              SizedBox(height: paddingMin),
                              ComponentsButton(
                                text: "Ubah data",
                                onTap: () => KidServices.editSingleKid(
                                  context,
                                  widget.id,
                                  kids.textNameController,
                                  kids.textNikController,
                                  componentsListHelper
                                      .gender[selectedGenderIndex],
                                  kids.textPlaceBirthController,
                                  formattedDate,
                                  kids.textHeightController,
                                  kids.textWeightController,
                                ),
                              ),
                              SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
