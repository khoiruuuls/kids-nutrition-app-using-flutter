// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/components_modal_bottom.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/pages/details/kid_edit_form.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

import '../../config/config_size.dart';
import '../../config/config_void.dart';
import '../../pages/first_page.dart';

class KidNav extends StatelessWidget {
  final String textTitle;
  final IconData? editIcon;
  final IconData? deleteIcon;
  final String id;
  const KidNav({
    required this.id,
    this.editIcon,
    this.deleteIcon,
    required this.textTitle,
    super.key,
  });

  void _showModalBottomSheet(BuildContext context, String message) {
    showCustomModalBottomSheet(context, message);
    navigateToPage(context, FirstPage());
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return Container(
      decoration: BoxDecoration(color: ConfigColor.darkBlue),
      child: Padding(
        padding: const EdgeInsets.all(paddingMin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textTitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: fontHeading,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => {navigateToPage(context, KidEditForm(id: id))},
                  child: Icon(editIcon),
                ),
                SizedBox(width: paddingMin),
                GestureDetector(
                  onTap: () async {
                    await firestoreService.userKidDelete(id);
                    navigateToPage(context, FirstPage());
                    _showModalBottomSheet(context, "Data berhasil Dihapus");
                  },
                  child: Icon(deleteIcon),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
