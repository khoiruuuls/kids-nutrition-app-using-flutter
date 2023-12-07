// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/components/components/list_kids_new.dart';
import '../../config/config_size.dart';
import '../details/kid_page.dart';
import 'components/home_header.dart';
import 'components/home_kids_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  void onSearch() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: paddingMin * 0.5),
            HomeKidsSearch(
              searchController: searchController,
              onSearch: onSearch,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("role", isEqualTo: "Anak Panti")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    List<DocumentSnapshot> filteredDocuments =
                        documents.where((document) {
                      var data = document.data() as Map<String, dynamic>;

                      var nameWithoutSpecialChars = data['name']
                          .toString()
                          .replaceAll(RegExp(r'[^\w\s]+'), '');
                      var name = nameWithoutSpecialChars.trim().toLowerCase();

                      return name
                          .contains(searchController.text.trim().toLowerCase());
                    }).toList();

                    if (filteredDocuments.isEmpty) {
                      return Center(
                        child: Text(
                          'No matching records',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: filteredDocuments.length,
                            itemBuilder: (context, index) {
                              var data = filteredDocuments[index].data()
                                  as Map<String, dynamic>;

                              var uid = data['uid'];
                              var name = data['name'];
                              var role = data['role'];
                              var timestamp = data["timestamp"];
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
                                  role: role,
                                  date: formattedDate,
                                  time: formattedTime,
                                  name: name,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 100),
                      ],
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
