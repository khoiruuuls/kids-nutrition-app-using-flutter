// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_color.dart';

import '../../config/config_size.dart';

class ComponentsSquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const ComponentsSquareTile({
    required this.onTap,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: paddingMin * 11,
        child: Container(
          decoration: BoxDecoration(
            color: ConfigColor.darkBlue,
            borderRadius: BorderRadius.circular(paddingMin),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(4, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: paddingMin * 1.85,
            vertical: paddingMin,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Login with",
                  style: TextStyle(
                    fontSize: paddingMin,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Image.asset(
                imagePath,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: paddingMin * 0.75),
            ],
          ),
        ),
      ),
    );
  }
}
