// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';
import 'package:kids_nutrition_app/pages/components/list_kids.dart';
import 'package:kids_nutrition_app/pages/home/components/home_header.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeHeader(),
            SizedBox(height: paddingMin / 2),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getKidsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List kidsList = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: kidsList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = kidsList[index];
                        String docsID = document.id;

                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String kidName = data['name'];
                        String kidNik = data['nik'];

                        return ListTile(
                          title: ListKids(
                            docId: docsID,
                            textName: kidName,
                            textNik: kidNik,
                          ),
                        );
                      },
                    );
                  } else {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
