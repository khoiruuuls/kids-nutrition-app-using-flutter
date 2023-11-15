// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kids_nutrition_app/pages/add_kid_page.dart';
import 'package:kids_nutrition_app/pages/home_page.dart';
import 'package:kids_nutrition_app/pages/setting_page.dart';
import 'package:line_icons/line_icons.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int selectedIndex = 0;

  void navigationBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<dynamic> appPage = [
    HomePage(),
    AddKidPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appPage[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GNav(
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 15,
          onTabChange: navigationBottomBar,
          gap: 8,
          color: Colors.black,
          activeColor: Colors.white,
          iconSize: 24,
          tabBackgroundColor: Colors.blue.shade300,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Beranda',
            ),
            GButton(
              icon: LineIcons.database,
              text: 'Tambah Data',
            ),
            GButton(
              icon: LineIcons.stream,
              text: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
