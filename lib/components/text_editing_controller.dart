// text_editing_controllers.dart

import 'package:flutter/material.dart';

class KidTextControllers {
  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textNikController = TextEditingController();
  final TextEditingController textGenderController = TextEditingController();
  final TextEditingController textPlaceBirthController =
      TextEditingController();
  final TextEditingController textDateBirthController = TextEditingController();
  final TextEditingController textHeightController = TextEditingController();
  final TextEditingController textWeightController = TextEditingController();
  final TextEditingController textAgeController = TextEditingController();
}

class UserController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

class NutritionTextControllers {
  final TextEditingController kaloriController = TextEditingController();
  final TextEditingController karbohidratController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController seratController = TextEditingController();
  final TextEditingController airController = TextEditingController();
  final TextEditingController lemakController = TextEditingController();
}
