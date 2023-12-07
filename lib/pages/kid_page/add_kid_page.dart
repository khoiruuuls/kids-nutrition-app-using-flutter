// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/components_button.dart';
import '../../components/components_modal_bottom.dart';
import '../../components/components_select_gender.dart';
import '../../components/components_title.dart';
import '../../components/date_picker.dart';
import '../../components/list_helper/component_list_helper.dart';
import '../../components/text_editing_controller.dart';
import '../../config/config_size.dart';
import '../../components/components/components/input_kids.dart';
import '../../components/components/kid_input_hw.dart';
import 'package:intl/intl.dart';

class AddKidPage extends StatefulWidget {
  const AddKidPage({super.key});

  @override
  State<AddKidPage> createState() => _AddKidPageState();
}

class _AddKidPageState extends State<AddKidPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  int selectedGenderIndex = 0;
  KidTextControllers kidTextControllers = KidTextControllers();
  UserController userController = UserController();
  ComponentsListHelper componentsListHelper = ComponentsListHelper();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await selectDate(context, selectedDate);

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _showModalBottomSheet(BuildContext context, String message) {
    showCustomModalBottomSheet(context, message);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ComponentsTitle(textTitle: "Tambah Data Anak"),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(paddingMin),
                      child: Column(
                        children: [
                          InputKids(
                            maxLength: 23,
                            text: "Nama Lengkap",
                            hintText: "Masukan Nama Lengkap",
                            controller: kidTextControllers.textNameController,
                            obscureText: false,
                          ),
                          SizedBox(height: paddingMin),
                          InputKids(
                            obscureText: false,
                            hintText: "Masukan Email kamu",
                            isAuth: true,
                            controller: userController.emailController,
                            text: "Email",
                          ),
                          SizedBox(height: paddingMin),
                          InputKids(
                            obscureText: true,
                            hintText: "Masukan Password kamu",
                            isAuth: true,
                            controller: userController.passwordController,
                            text: "Password",
                          ),
                          SizedBox(height: paddingMin),
                          InputKids(
                            maxLength: 16,
                            text: "NIK",
                            hintText: "Masukan NIK",
                            isNumeric: true,
                            controller: kidTextControllers.textNikController,
                            obscureText: false,
                          ),
                          SizedBox(height: paddingMin),
                          ComponentsSelectGender(
                            onGenderSelected: (index) {
                              setState(() {
                                selectedGenderIndex = index;
                              });
                            },
                          ),
                          InputKids(
                            maxLength: 20,
                            text: "Tempat lahir",
                            hintText: "Masukan Tempat Lahir",
                            controller:
                                kidTextControllers.textPlaceBirthController,
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
                            controllerHeight:
                                kidTextControllers.textHeightController,
                            controllerWeight:
                                kidTextControllers.textWeightController,
                          ),
                          SizedBox(height: paddingMin),
                          ComponentsButton(
                            text: "Tambah data",
                            onTap: () async {
                              try {
                                String name = kidTextControllers
                                    .textNameController.text
                                    .trim();
                                if (name.isEmpty) {
                                  showCustomModalBottomSheet(
                                      context, "Nama tidak boleh kosong");
                                  return;
                                }

                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: userController.emailController.text,
                                  password:
                                      userController.passwordController.text,
                                );

                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(userCredential.user!.uid)
                                    .set({
                                  'uid': userCredential.user!.uid,
                                  'name': name,
                                  'email': userCredential.user!.email,
                                  'role': "Anak Panti",
                                  'gender': componentsListHelper
                                      .gender[selectedGenderIndex],
                                  'weight': 0.0,
                                  'height': 0.0,
                                  'bio': "No data record .",
                                  'phone': "No data record .",
                                  'nik': "No data record .",
                                  'dateBirth': "No data record .",
                                  'placeBirth': "No data record .",
                                  'timestamp': Timestamp.now(),
                                });

                                showCustomModalBottomSheet(
                                  context,
                                  "Berhasil ditambahkan",
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "channel-error") {
                                  showCustomModalBottomSheet(
                                    context,
                                    "Email dan password harus dimasukan",
                                  );
                                } else if (e.code == "invalid-email") {
                                  showCustomModalBottomSheet(
                                    context,
                                    "Masukan Email dengan benar",
                                  );
                                } else {
                                  showCustomModalBottomSheet(
                                    context,
                                    e.code,
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
