// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  /* ------ users */

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  /* ------ read users */

  Stream<QuerySnapshot> getUserDetail(String email) {
    final userStream = users.where("email", isEqualTo: email).snapshots();
    return userStream;
  }

  /* ------ update users */

  Future<void> updateUser(
    String userEmail,
    String updatedEmail,
    String updatedRole,
    String updatedName,
    String updatedPhone,
  ) async {
    try {
      final userDoc = await users.doc(userEmail).get();

      if (userDoc.exists) {
        print('Document found for email: $userEmail');
        await users.doc(userEmail).update({
          'email': updatedEmail,
          'role': updatedRole,
          'name': updatedName,
          'phone': updatedPhone,
        });
        print('User updated successfully');
      } else {
        // Handle the case where the document does not exist
        print('Document not found for email: $userEmail');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  /* ------ add kids */

  Future<void> addKid(
    String name,
    String nik,
    String gender,
    String placeBirth,
    String dateBirth,
    double height,
    double weight,
  ) {
    return users.add({
      'name': name,
      'nik': nik,
      'gender': gender,
      'role': 'Anak Panti',
      'placeBirth': placeBirth,
      'dateBirth': dateBirth,
      'height': height,
      'weight': weight,
      'timestamp': Timestamp.now(),
    });
  }

  /* ------ read kids */

  /* ------ update kids */

  Future<void> updateKid(
    String id,
    String newName,
    String newNik,
    String newGender,
    String newPlaceBirth,
    String newDateBirth,
    double newHeight,
    double newWeight,
  ) {
    return users.doc(id).update({
      'name': newName,
      'nik': newNik,
      'gender': newGender,
      'placeBirth': newPlaceBirth,
      'dateBirth': newDateBirth,
      'height': newHeight,
      'weight': newWeight,
      'timestamp': Timestamp.now(),
    });
  }

  /* ------ delete kids */

  Future<void> userKidDelete(String id) async {
    await users.doc(id).delete();
  }

  /* ------ nutritions */

  final CollectionReference nutrition =
      FirebaseFirestore.instance.collection("nutritions");

  /* ------ read nutritions */

  Future<DocumentSnapshot> getNutritionById(String nutritionId) async {
    return await nutrition.doc(nutritionId).get();
  }

  /* ------ kid_nutrition */

  final CollectionReference kidNutrition =
      FirebaseFirestore.instance.collection("kid_nutrition");

  /* ------ add kid_nutrition */

  Future<void> addKidNutritionRelation(String kidId, String nutritionId) {
    return kidNutrition.doc(nutritionId).set({
      'kidId': kidId,
      'nutritionId': nutritionId,
      "timestamp": Timestamp.now(),
    });
  }

  /* ------ read nutrition on specific id */

  Stream<QuerySnapshot> getNutritionForKid(String id) {
    final nutritionStream =
        kidNutrition.where('kidId', isEqualTo: id).snapshots();
    return nutritionStream;
  }

  /* ------ nutritional_need */

  final CollectionReference nutritionNeed =
      FirebaseFirestore.instance.collection("nutritional_need");

  /* ------ add nutritional_need */

  Future<void> addNutritionalNeed(
    double kaloriController,
    double karbohidratController,
    double proteinController,
    double seratController,
    double airController,
    double lemakController,
    String genderController,
    int ageController,
  ) {
    return nutritionNeed.add({
      'kalori': kaloriController,
      'karbohidrat': karbohidratController,
      'lemak': lemakController,
      'protein': proteinController,
      'air': airController,
      'serat': seratController,
      'gender': genderController,
      'age': ageController,
      'timestamp': Timestamp.now(),
    });
  }

  // create

  Future<DocumentReference> addNutrition(
    String name,
    String image,
    double kalori,
    double karbohidrat,
    double lemak,
    double protein,
    double water,
    double fiber,
  ) {
    return nutrition.add({
      'name': name,
      'image': image,
      'kalori': kalori,
      'karbohidrat': karbohidrat,
      'lemak': lemak,
      'protein': protein,
      'water': water,
      'fiber': fiber,
      'timestamp': Timestamp.now(),
    });
  }

  /* ------ add nutritional_need */
  final CollectionReference roles =
      FirebaseFirestore.instance.collection("roles");

  getKidsStream() {}
}
