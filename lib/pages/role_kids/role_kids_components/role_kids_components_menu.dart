// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:line_icons/line_icon.dart';

import '../../../config/config_class.dart';
import '../../../config/config_color.dart';
import '../../../config/config_size.dart';
import '../../../config/config_void.dart';
import '../../auth_page/auth_page.dart';
import 'role_kids_edit.dart';

class KidsRoleComponentsMenu extends StatelessWidget {
  final String id;
  const KidsRoleComponentsMenu({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);

    logoutField() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Apakah anda yakin ingin logout dari akun ini ?",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Tidak",
                  style: GoogleFonts.poppins(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  navigateToPage(context, AuthPage());
                },
                child: Text(
                  "Ya",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          );
        },
      );
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: 48,
        maxWidth: ConfigSize.blockSizeHorizontal! * 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(paddingMin),
        color: ConfigColor.darkBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: MenuIconOnTap(
              onTap: () => {navigateToPage(context, RoleKidsEdit(id: id))},
              icon: LineIcon.edit(color: Colors.white),
            ),
          ),
          LineDevider(heightLine: 2, chooseColor: Colors.white),
          Expanded(
            child: MenuIconOnTap(
              onTap: logoutField,
              icon: LineIcon.alternateSignOut(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
