// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/components/kid_main.dart';
import 'role_kids_components/role_kids_components_title.dart';
import 'role_kids_components/role_kids_floating_button.dart';

class RoleKidsPage extends StatelessWidget {
  final String id;

  const RoleKidsPage({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            RoleKidsComponentsTitle(textTitle: "Kids Data Single", id: id),
            KidMain(id: id),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: RoleKidsFloatingButton(
        id: id,
        icon: LineIcons.plus,
      ),
    );
  }
}
