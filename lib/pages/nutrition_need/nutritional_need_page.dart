// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unused_element, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components/little_components/kid_hw.dart';
import '../../components/components/components/input_kids.dart';
import '../../components/components_button.dart';
import '../../services/kid_services.dart';
import '../../components/text_editing_controller.dart';
import '../../config/config_size.dart';
import '../../components/components/kid_nav.dart';

class NutritionalNeed extends StatefulWidget {
  const NutritionalNeed({super.key});

  @override
  State<NutritionalNeed> createState() => _NutritionalNeedState();
}

class _NutritionalNeedState extends State<NutritionalNeed> {
  NutritionTextControllers nutritionTextControllers =
      NutritionTextControllers();
  KidTextControllers kidTextControllers = KidTextControllers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KidNav(id: "", textTitle: "Add Nutritional Need"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(paddingMin),
                      child: Column(
                        children: [
                          InputKids(
                            maxLength: 16,
                            text: "Jenis Kelamin",
                            hintText: "Masukan Jenis Kelamin",
                            controller: kidTextControllers.textGenderController,
                            obscureText: false,
                          ),
                          KidHw(
                            hintText: 2.3,
                            controller: kidTextControllers.textAgeController,
                            textMeasure: "",
                            textTitle: "Age",
                            isNumeric: true,
                          ),
                          SizedBox(height: paddingMin),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KidHw(
                                hintText: 2.3,
                                controller:
                                    nutritionTextControllers.kaloriController,
                                textMeasure: "",
                                textTitle: "kaloriController",
                                isNumeric: true,
                              ),
                              KidHw(
                                hintText: 2.3,
                                controller:
                                    nutritionTextControllers.proteinController,
                                textMeasure: "",
                                textTitle: "proteinController",
                                isNumeric: true,
                              ),
                            ],
                          ),
                          SizedBox(height: paddingMin),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KidHw(
                                hintText: 2.3,
                                controller:
                                    nutritionTextControllers.lemakController,
                                textMeasure: "",
                                textTitle: "lemakController",
                                isNumeric: true,
                              ),
                              KidHw(
                                hintText: 2.3,
                                controller: nutritionTextControllers
                                    .karbohidratController,
                                textMeasure: "",
                                textTitle: "karbohidratController",
                                isNumeric: true,
                              ),
                            ],
                          ),
                          SizedBox(height: paddingMin),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KidHw(
                                hintText: 2.3,
                                controller:
                                    nutritionTextControllers.seratController,
                                textMeasure: "",
                                textTitle: "seratController",
                                isNumeric: true,
                              ),
                              KidHw(
                                hintText: 2.3,
                                controller:
                                    nutritionTextControllers.airController,
                                textMeasure: "",
                                textTitle: "airController",
                                isNumeric: true,
                              ),
                            ],
                          ),
                          SizedBox(height: paddingMin),
                          ComponentsButton(
                            text: "Tambah Data",
                            onTap: () => KidServices.addNutritionalNeed(
                              context,
                              nutritionTextControllers.kaloriController,
                              nutritionTextControllers.karbohidratController,
                              nutritionTextControllers.proteinController,
                              nutritionTextControllers.seratController,
                              nutritionTextControllers.airController,
                              nutritionTextControllers.lemakController,
                              kidTextControllers.textGenderController,
                              kidTextControllers.textAgeController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
