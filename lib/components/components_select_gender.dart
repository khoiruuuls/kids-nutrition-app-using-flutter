// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_nutrition_app/components/list_helper/component_list_helper.dart';

import '../config/config_color.dart';
import '../config/config_size.dart';

class ComponentsSelectGender extends StatefulWidget {
  final Function(int) onGenderSelected;

  const ComponentsSelectGender({required this.onGenderSelected, Key? key})
      : super(key: key);

  @override
  State<ComponentsSelectGender> createState() => _ComponentsSelectGenderState();
}

class _ComponentsSelectGenderState extends State<ComponentsSelectGender> {
  ComponentsListHelper componentsListHelper = ComponentsListHelper();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingMin * 1.5),
          child: Text(
            "Pilih Gender kamu",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: paddingMin),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: componentsListHelper.gender.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                    widget.onGenderSelected(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? paddingMin : 15,
                        right: index == 6 - 1 ? paddingMin : 0),
                    padding: EdgeInsets.symmetric(horizontal: paddingMin * 2),
                    decoration: BoxDecoration(
                        color: current == index
                            ? ConfigColor.darkBlue
                            : Colors.white,
                        border: current == index
                            ? null
                            : Border.all(
                                color: Colors.grey.shade100,
                              ),
                        borderRadius: BorderRadius.circular(paddingMin)),
                    child: Row(
                      children: [
                        Text(
                          componentsListHelper.gender[index],
                          style: GoogleFonts.poppins(
                            color:
                                current == index ? Colors.white : Colors.black,
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
      ],
    );
  }
}
