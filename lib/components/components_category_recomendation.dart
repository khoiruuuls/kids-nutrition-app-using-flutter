// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config_color.dart';
import '../config/config_size.dart';
import 'list_helper/component_list_helper.dart';

class ComponentsCategoryRecomendation extends StatefulWidget {
  final Function(String) onCategorySelected;

  const ComponentsCategoryRecomendation({
    required this.onCategorySelected,
    Key? key,
  }) : super(key: key);

  @override
  State<ComponentsCategoryRecomendation> createState() =>
      _ComponentsCategoryRecomendationState();
}

class _ComponentsCategoryRecomendationState
    extends State<ComponentsCategoryRecomendation> {
  ComponentsListHelper componentsListHelper = ComponentsListHelper();
  int current = -1;

  late List<String> shuffledFood;

  @override
  void initState() {
    super.initState();
    shuffledFood = List.from(componentsListHelper.food)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingMin * 1.5),
          child: Text(
            "Rekomendasi makanan",
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
            height: 36,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                    widget.onCategorySelected(shuffledFood[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? paddingMin : 15,
                        right: index == 6 - 1 ? paddingMin : 0),
                    padding: EdgeInsets.symmetric(horizontal: paddingMin),
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
                          shuffledFood[index], // Display the shuffled food item
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
