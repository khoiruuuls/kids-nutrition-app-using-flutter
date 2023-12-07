// kid_operations.dart

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/first_page.dart';
import '../pages/role_kids/role_kids_page.dart';
import 'firestore.dart';
import '../components/components_modal_bottom.dart';

class KidServices {
  static final FirestoreService _firestoreService = FirestoreService();

  static Future<void> editKid(
    BuildContext context,
    String id,
    TextEditingController nameController,
    TextEditingController nikController,
    String genderController,
    TextEditingController placeBirthController,
    String formattedDate,
    TextEditingController heightController,
    TextEditingController weightController,
  ) async {
    if (nameController.text.isEmpty ||
        nikController.text.isEmpty ||
        placeBirthController.text.isEmpty ||
        formattedDate.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      _showModalBottomSheet(context, "Semua input harus diisi");
    } else {
      await _firestoreService.updateKid(
        id,
        nameController.text,
        nikController.text,
        genderController,
        placeBirthController.text,
        formattedDate,
        double.parse(heightController.text),
        double.parse(weightController.text),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
      );
      _showModalBottomSheet(context, "Berhasil diubah");
    }
  }

  static Future<void> editSingleKid(
    BuildContext context,
    String id,
    TextEditingController nameController,
    TextEditingController nikController,
    String genderController,
    TextEditingController placeBirthController,
    String formattedDate,
    TextEditingController heightController,
    TextEditingController weightController,
  ) async {
    if (nameController.text.isEmpty ||
        nikController.text.isEmpty ||
        placeBirthController.text.isEmpty ||
        formattedDate.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      _showModalBottomSheet(context, "Semua input harus diisi");
    } else {
      await _firestoreService.updateKid(
        id,
        nameController.text,
        nikController.text,
        genderController,
        placeBirthController.text,
        formattedDate,
        double.parse(heightController.text),
        double.parse(weightController.text),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoleKidsPage(id: id),
        ),
      );
      _showModalBottomSheet(context, "Berhasil diubah");
    }
  }

  static Future<void> addKid(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController nikController,
    String genderController,
    TextEditingController placeBirthController,
    String formattedDate,
    TextEditingController heightController,
    TextEditingController weightController,
  ) async {
    if (nameController.text.isEmpty ||
        nikController.text.isEmpty ||
        placeBirthController.text.isEmpty ||
        formattedDate.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      _showModalBottomSheet(context, "Semua input harus diisi");
    } else {
      await _firestoreService.addKid(
        nameController.text,
        nikController.text,
        genderController,
        placeBirthController.text,
        formattedDate,
        double.parse(heightController.text),
        double.parse(weightController.text),
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
      );
      _showModalBottomSheet(context, "Berhasil ditambahkan");
    }
  }

  static Future<void> addNutritionalNeed(
    BuildContext context,
    TextEditingController kaloriController,
    TextEditingController karbohidratController,
    TextEditingController proteinController,
    TextEditingController seratController,
    TextEditingController airController,
    TextEditingController lemakController,
    TextEditingController genderController,
    TextEditingController ageController,
  ) async {
    await _firestoreService.addNutritionalNeed(
      double.parse(kaloriController.text),
      double.parse(karbohidratController.text),
      double.parse(proteinController.text),
      double.parse(seratController.text),
      double.parse(airController.text),
      double.parse(lemakController.text),
      genderController.text,
      int.parse(ageController.text),
    );
    _showModalBottomSheet(context, "Berhasil ditambahkan");
  }

  static void _showModalBottomSheet(BuildContext context, String message) {
    showCustomModalBottomSheet(context, message);
  }
}
