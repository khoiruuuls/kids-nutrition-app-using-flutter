// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_element, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/pages/components/button_kids.dart';
import 'package:kids_nutrition_app/pages/components/input_kids.dart';
import 'package:kids_nutrition_app/pages/details/components/kid_input_hw.dart';
import 'package:kids_nutrition_app/pages/first_page.dart';

import '../../main.dart';
import '../../services/firestore.dart';
import 'components/kid_nav.dart';

class KidEditForm extends StatefulWidget {
  final String docId;
  const KidEditForm({
    required this.docId,
    super.key,
  });

  @override
  State<KidEditForm> createState() => _KidEditFormState();
}

class _KidEditFormState extends State<KidEditForm> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textNikController = TextEditingController();
  final TextEditingController textGenderController = TextEditingController();
  final TextEditingController textPlaceBirthController =
      TextEditingController();
  final TextEditingController textDateBirthController = TextEditingController();
  final TextEditingController textHeightController = TextEditingController();
  final TextEditingController textWeightController = TextEditingController();

  Future<Map<String, dynamic>> getKidData(String docId) async {
    final DocumentSnapshot kidDocument =
        await FirebaseFirestore.instance.collection('kids').doc(docId).get();
    return kidDocument.data() as Map<String, dynamic>;
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(paddingMin),
          topRight: Radius.circular(paddingMin),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        // Display the modal bottom sheet content
        return Container(
          height: 100,
          child: Center(
            child: Text(
              "Berhasil diubah",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );

    // Close the modal bottom sheet after 1 second
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(selectedDate);
    return FutureBuilder<Map<String, dynamic>>(
      future: getKidData(widget.docId), // Fetch kid's data based on docId
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final data = snapshot.data!;

          // Extract the required fields
          final name = data['name'];
          final nik = data['nik'];
          final gender = data['gender'];
          final placeBirth = data['placeBirth'];
          final height = data['height'];
          final weight = data['weight'];

          final FirestoreService firestoreService = FirestoreService();

          return Scaffold(
            // Rest of your KidEditForm widget
            body: SafeArea(
              child: Column(
                children: [
                  KidNav(
                    docId: widget.docId,
                    textTitle: "Edit Data Anak",
                  ),
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
                                  docId: widget.docId,
                                  text: "Nama Lengkap",
                                  hintText: name,
                                  controller:
                                      textNameController, // Set hintText from the data
                                ),
                                SizedBox(height: paddingMin),
                                InputKids(
                                  docId: widget.docId,
                                  text: "NIK",
                                  hintText: nik,
                                  controller:
                                      textNikController, // Set hintText from the data
                                ),
                                SizedBox(height: paddingMin),
                                InputKids(
                                  docId: widget.docId,
                                  text: "Jenis Kelamin",
                                  hintText:
                                      gender, // Set hintText from the data
                                  controller:
                                      textGenderController, // Set hintText from the data
                                ),
                                SizedBox(height: paddingMin),
                                InputKids(
                                  docId: widget.docId,
                                  text: "Tempat lahir",
                                  hintText:
                                      placeBirth, // Set hintText from the data
                                  controller:
                                      textPlaceBirthController, // Set hintText from the data
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
                                            borderRadius: BorderRadius.circular(
                                                paddingMin / 2),
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
                                  hintTextHeight: height,
                                  hintTextWeight: weight,
                                  controllerHeight: textHeightController,
                                  controllerWeight: textWeightController,
                                ),
                                SizedBox(height: paddingMin),
                                ButtonKids(
                                  text: "Ubah data",
                                  onTap: () async {
                                    await firestoreService.updateKid(
                                      widget.docId,
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
                                    _showModalBottomSheet(context);
                                  },
                                )
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
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
