// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config_size.dart';

class ComponentsInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const ComponentsInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  _ComponentsInputState createState() => _ComponentsInputState();
}

class _ComponentsInputState extends State<ComponentsInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingMin),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            obscureText: widget.obscureText && _obscureText,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              border: kInputBorder,
              errorBorder: kInputBorder,
              focusedBorder: sInputBorder,
              enabledBorder: kInputBorder,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: paddingMin * 5 / 4,
                horizontal: paddingMin * 3 / 2,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
