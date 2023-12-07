// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../config/config_color.dart';
import '../config/config_size.dart';
import '../pages/details/kid_edit_form.dart';
import '../pages/first_page.dart';
import '../services/firestore.dart';

class ComponentsMenu extends StatelessWidget {
  final String id;
  const ComponentsMenu({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);

    deleteField() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Apakah anda yakin ingin menghapus data anak panti asuhan ini ?",
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
                  await FirestoreService().userKidDelete(id);
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstPage(),
                    ),
                  );
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
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => KidEditForm(
                          id: id,
                        )),
                  ),
                ),
              },
              child: Center(
                child: LineIcon.edit(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: ConfigSize.blockSizeVertical! * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: deleteField,
              child: Center(
                child: LineIcon.trash(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
