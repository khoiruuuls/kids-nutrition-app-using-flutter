// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/model_message.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(
      String receiverId, String message, Timestamp timestamp) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp, // send this to the user field as update field
    );
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
  }

  Future<void> updateTimestamp(
      String senderId, String receiverId, Timestamp timestamp) async {
    // Update timestamp for sender
    await firebaseFirestore
        .collection("users")
        .doc(senderId)
        .update({'timestamp': timestamp});

    // Update timestamp for receiver
    await firebaseFirestore
        .collection("users")
        .doc(receiverId)
        .update({'timestamp': timestamp});
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy(
          "timestamp",
          descending: false,
        )
        .snapshots();
  }
}
