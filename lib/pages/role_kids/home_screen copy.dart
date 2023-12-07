// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/config/config_size.dart';
import 'package:line_icons/line_icon.dart';

import '../../components/components_little_card.dart';
import '../auth_page/auth_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "All items",
    "Dress",
    "Hat",
    "Watch",
    "Watch",
    "Watch",
  ];
  List<String> images = [
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
    "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
  ];
  List<String> titles = [
    "Ini image ke 1",
    "Ini image ke 2",
    "Ini image ke 3",
    "Ini image ke 4",
    "Ini image ke 5",
    "Ini image ke 6",
    "Ini image ke 7",
    "Ini image ke 8",
    "Ini image ke 9",
    "Ini image ke 10",
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingMin * 2, vertical: paddingMin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello, Good Morning ✌️",
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        "Muhamad Khoirul Fahmi",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: paddingMin,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      "https://getillustrations.b-cdn.net//photos/pack/3d-avatar-male_lg.png",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingMin,
              ),
              child: TextField(
                style: GoogleFonts.poppins(),
                controller: TextEditingController(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(paddingMin),
                  prefixIcon: IconTheme(
                    data: IconThemeData(color: Colors.grey.shade300),
                    child: LineIcon.search(),
                  ),
                  hintText: "Mau Makan Apa ?",
                  border: kInputBorder,
                  errorBorder: kInputBorder,
                  focusedBorder: kInputBorder,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: paddingMin),
              child: SizedBox(
                width: double.infinity,
                height: 36,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? paddingMin : 15,
                            right: index == categories.length - 1
                                ? paddingMin
                                : 0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: current == index
                              ? ConfigColor.darkBlue
                              : Colors.white,
                          border: current == index
                              ? null
                              : Border.all(
                                  color: Colors.grey.shade100,
                                ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              categories[index],
                              style: GoogleFonts.poppins(
                                color: current == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: paddingMin, right: paddingMin, bottom: paddingMin),
              child: ComponentsLittleCard(
                text: "Log out",
                icon: Icons.logout,
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthPage()));
                  } catch (e) {
                    // Handle sign-out errors if necessary
                    print('Sign-out error: $e');
                  }
                },
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  MasonryGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 25,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: images.length,
                    padding: EdgeInsets.symmetric(horizontal: paddingMin),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: index == 1
                                ? 280
                                : 240, // Set the desired height
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(paddingMin),
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              titles[index],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
