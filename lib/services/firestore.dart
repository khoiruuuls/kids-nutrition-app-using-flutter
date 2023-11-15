// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference kids =
      FirebaseFirestore.instance.collection("kids");

  final CollectionReference nutrition =
      FirebaseFirestore.instance.collection("nutritions");

  final CollectionReference kidNutrition =
      FirebaseFirestore.instance.collection("kid_nutrition");

  Future<void> addKidNutritionRelation(String kidId, String nutritionId) {
    return kidNutrition.add({
      'kidId': kidId,
      'nutritionId': nutritionId,
      "timestamp": Timestamp.now(),
    });
  }

  // create
  Future<void> addKid(
    String name,
    String nik,
    String gender,
    String placeBirth,
    String dateBirth,
    String height,
    String weight,
  ) {
    return kids.add({
      'name': name,
      'nik': nik,
      'gender': gender,
      'placeBirth': placeBirth,
      'dateBirth': dateBirth,
      'height': height,
      'weight': weight,
      'timestamp': Timestamp.now(),
    });
  }

  Future<DocumentReference> addNutrition(
    String name,
    double kalori, // Change to double
    double karbohidrat, // Change to double
    double lemak, // Change to double
    double protein, // Change to double
  ) {
    return nutrition.add({
      'name': name,
      'kalori': kalori,
      'karbohidrat': karbohidrat,
      'lemak': lemak,
      'protein': protein,
      'timestamp': Timestamp.now(),
    });
  }

  Future<Map<String, dynamic>> getKidData(String docId) async {
    final DocumentSnapshot kidDocument =
        await FirebaseFirestore.instance.collection('kids').doc(docId).get();
    return kidDocument.data() as Map<String, dynamic>;
  }

  // read
  Stream<QuerySnapshot> getKidsStream() {
    final kidStream = kids.orderBy("timestamp", descending: true).snapshots();
    return kidStream;
  }

  // Read nutrition data for a specific kid
  Stream<QuerySnapshot> getNutritionForKid(String kidId) {
    final nutritionStream =
        kidNutrition.where('kidId', isEqualTo: kidId).snapshots();
    return nutritionStream;
  }

  // read user detail
  Stream<QuerySnapshot> getUserDetail(String email) {
    final userStream = users.where("email", isEqualTo: email).snapshots();
    return userStream;
  }

  Future<DocumentSnapshot> getNutritionById(String nutritionId) async {
    return await nutrition.doc(nutritionId).get();
  }

  Stream<QuerySnapshot> getNutritionUsingId() {
    final nutritionStream =
        nutrition.orderBy("timestamp", descending: true).snapshots();
    return nutritionStream;
  }

  // make a read data from selected Kid ID

  // update

  Future<void> updateKid(
    String docId,
    String newName,
    String newNik,
    String newGender,
    String newPlaceBirth,
    String newDateBirth,
    String newHeight,
    String newWeight,
  ) {
    return kids.doc(docId).update({
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

  Future<void> updateUser(
    String userEmail,
    String updatedEmail,
    String updatedRole,
    String updatedName,
    String updatedPhone,
  ) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users');

      final userDoc = await userRef.doc(userEmail).get();

      if (userDoc.exists) {
        print('Document found for email: $userEmail');
        await userRef.doc(userEmail).update({
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
      // Handle errors as needed
    }
  }

  // delete
  Future<void> deleteKid(String docId) {
    return kids.doc(docId).delete();
  }
}
