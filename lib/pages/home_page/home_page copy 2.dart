// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/components/components/list_kids_new.dart';
import '../../config/config_size.dart';
import '../details/kid_page.dart';
import 'components/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: paddingMin / 2),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("roles")
                    .where("role", isEqualTo: "Anak Panti")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    if (documents.isEmpty) {
                      return Center(
                        child: Text(
                          'No data records yet',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        var data =
                            documents[index].data() as Map<String, dynamic>;

                        var uid = data['uid'];

                        return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var userData = snapshot.data!.data();
                              var userName = userData?["name"] ?? "No Name";

                              // Added a null check for timestamp
                              var timestamp = userData?["timestamp"];
                              if (timestamp == null) {
                                // Handle the case where timestamp is null
                                return Text("Timestamp is null");
                              }

                              String formattedDate = DateFormat('dd MMMM yyyy')
                                  .format(timestamp.toDate());
                              String formattedTime = DateFormat('hh : mm')
                                  .format(timestamp.toDate());

                              return ListTile(
                                title: ListKidsNew(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KidPage(id: uid),
                                      ),
                                    );
                                  },
                                  id: uid,
                                  date: formattedDate,
                                  time: formattedTime,
                                  name: userName,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text("");
                            }
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No data records yet',
                        style: GoogleFonts.poppins(),
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
