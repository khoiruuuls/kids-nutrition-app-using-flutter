import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_size.dart';

import 'components/kid_compare.dart';
import 'components/kid_target.dart';

class ComponentsScrolledHorizontal extends StatelessWidget {
  final String id;
  final String gender;
  final int age;
  const ComponentsScrolledHorizontal({
    super.key,
    required this.id,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KidCompare(
          age: age,
          gender: gender,
        ),
        const SizedBox(height: paddingMin),
        KidTarget(id: id),
      ],
    );
  }
}
