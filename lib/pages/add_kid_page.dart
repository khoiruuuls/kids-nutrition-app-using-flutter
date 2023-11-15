// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unused_element, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../main.dart';
import 'components/button_kids.dart';
import 'components/input_kids.dart';
import 'details/components/kid_input_hw.dart';
import 'details/components/kid_nav.dart';
import 'package:intl/intl.dart';

class AddKidPage extends StatefulWidget {
  const AddKidPage({super.key});

  @override
  State<AddKidPage> createState() => _AddKidPageState();
}

class _AddKidPageState extends State<AddKidPage> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textNikController = TextEditingController();
  final TextEditingController textGenderController = TextEditingController();
  final TextEditingController textPlaceBirthController =
      TextEditingController();
  final TextEditingController textHeightController = TextEditingController();
  final TextEditingController textWeightController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // highlight color
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _showModalBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(paddingMin),
          topRight: Radius.circular(paddingMin),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KidNav(docId: "", textTitle: "Tambah data anak"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(paddingMin),
                      child: Column(
                        children: [
                          SizedBox(height: paddingMin),
                          InputKids(
                            maxLength: 25,
                            text: "Nama Lengkap",
                            hintText: "Masukan Nama Lengkap",
                            controller: textNameController,
                          ),
                          SizedBox(height: paddingMin),
                          InputKids(
                            maxLength: 16,
                            text: "NIK",
                            hintText: "Masukan NIK",
                            isNumeric: true,
                            controller: textNikController,
                          ),
                          SizedBox(height: paddingMin),
                          InputKids(
                            maxLength: 15,
                            text: "Jenis Kelamin",
                            hintText: "Masukan Jenis Kelamin",
                            controller: textGenderController,
                          ),
                          SizedBox(height: paddingMin),
                          InputKids(
                            maxLength: 20,
                            text: "Tempat lahir",
                            hintText: "Masukan Tempat Lahir",
                            controller: textPlaceBirthController,
                          ),
                          SizedBox(height: paddingMin),
                          Row(
                            children: [
                              Container(
                                width: 110,
                                child: Text(
                                  "Tanggal lahir",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
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
                                          color: Colors.grey.shade500),
                                      borderRadius:
                                          BorderRadius.circular(paddingMin / 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    width: double.infinity,
                                    child: Text(formattedDate),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          KidInputHw(
                            controllerHeight: textHeightController,
                            controllerWeight: textWeightController,
                          ),
                          SizedBox(height: paddingMin),
                          ButtonKids(
                            text: "Tambah Data",
                            onTap: () async {
                              if (textNameController.text.isEmpty ||
                                  textNikController.text.isEmpty ||
                                  textGenderController.text.isEmpty ||
                                  textPlaceBirthController.text.isEmpty ||
                                  formattedDate.isEmpty ||
                                  textHeightController.text.isEmpty ||
                                  textWeightController.text.isEmpty) {
                                _showModalBottomSheet(
                                    context, "Semua input harus diisi");
                              } else {
                                await firestoreService.addKid(
                                  textNameController.text,
                                  textNikController.text,
                                  textGenderController.text,
                                  textPlaceBirthController.text,
                                  formattedDate,
                                  textHeightController.text,
                                  textWeightController.text,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstPage(),
                                  ),
                                );
                                _showModalBottomSheet(
                                  context,
                                  "Berhasil ditambahkan",
                                );
                              }
                            },
                          ),
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
