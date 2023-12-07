// ignore_for_file: curly_braces_in_flow_control_structures, unused_element, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/components/components_select_gender.dart';

import '../../../components/components/components/input_kids.dart';
import '../../../components/components/kid_input_hw.dart';
import '../../../components/components_back.dart';
import '../../../components/components_button.dart';
import '../../../components/components_modal_bottom.dart';
import '../../../components/date_picker.dart';
import '../../../components/list_helper/component_list_helper.dart';
import '../../../components/text_editing_controller.dart';
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMin),
                      child: Column(
                        children: [
                          SizedBox(height: paddingMin),
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
                              componentsListHelper.gender[selectedGenderIndex],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
