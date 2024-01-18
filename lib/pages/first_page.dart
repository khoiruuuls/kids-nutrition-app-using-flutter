// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kids_nutrition_app/config/config_size.dart';
import 'package:kids_nutrition_app/pages/chat_page/chat_page.dart';
import 'package:line_icons/line_icons.dart';

import '../config/config_color.dart';
import 'test/test_message_notification.dart';
import 'home_page/home_page.dart';
import 'profile_page/profile_page.dart';

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
    // TestMessageNotification(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appPage[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: paddingMin * 1.25,
          vertical: paddingMin,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ConfigColor.darkBlue,
            borderRadius: BorderRadius.circular(paddingMin),
          ),
          child: Padding(
            padding: const EdgeInsets.all(paddingMin * 0.5),
            child: GNav(
              rippleColor: ConfigColor.darkBlue,
              hoverColor: ConfigColor.darkBlue,
              haptic: true,
              tabBorderRadius: paddingMin * 0.5,
              onTabChange: navigationBottomBar,
              gap: 8,
              color: Colors.white,
              activeColor: ConfigColor.darkBlue,
              iconSize: 24,
              tabBackgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: paddingMin,
                vertical: paddingMin * 0.75,
              ),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.whatSApp,
                  text: 'Chat',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
