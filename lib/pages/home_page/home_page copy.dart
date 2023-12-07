// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_nutrition_app/pages/details/kid_page.dart';

import '../../components/components/components/list_kids_new.dart';
import '../../config/config_size.dart';
import '../../services/firestore.dart';
import 'components/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: paddingMin / 2),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getKidsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    List list = snapshot.data!.docs;
                    if (list.isEmpty) {
                      return Center(
                        child: Text(
                          'No data records yet',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('error'),
                      );
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document = list[index];
                              String docsID = document.id;

                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              final timestamp = data['timestamp'];

                              String formattedDate = DateFormat('dd MMM yyyy')
                                  .format(timestamp.toDate());
                              String formattedTime = DateFormat('hh : mm')
                                  .format(timestamp.toDate());

                              return ListTile(
                                title: ListKidsNew(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            KidPage(id: docsID),
                                      ),
                                    );
                                  },
                                  id: docsID,
                                  date: formattedDate,
                                  time: formattedTime,
                                  name: data['name'],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 100)
                      ],
                    );
                  } else {
                    return Scaffold(
                      body: Center(
                        child: Text(
                          'No data records yet',
                          style: GoogleFonts.poppins(),
                        ),
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
