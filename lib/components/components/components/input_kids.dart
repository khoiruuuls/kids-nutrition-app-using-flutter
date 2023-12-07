// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config_size.dart';

class InputKids extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;
  final String? id;
  final int? maxLength;
  final bool isNumeric;
  final bool isAuth;
  final bool obscureText;

  const InputKids({
    required this.obscureText,
    this.isNumeric = false,
    this.isAuth = false,
    this.maxLength,
    this.id,
    this.controller,
    required this.hintText,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  State<InputKids> createState() => _InputKidsState();
}

class _InputKidsState extends State<InputKids> {
  Future<Map<String, dynamic>> getKidData(String id) async {
    final DocumentSnapshot kidDocument =
        await FirebaseFirestore.instance.collection('kids').doc(id).get();
    return kidDocument.data() as Map<String, dynamic>;
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    if (widget.isNumeric) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else if (widget.isAuth) {
      // Allow all characters for authentication
      inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'[\s\S]*'))];
    } else {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingMin * 1.5),
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              fontSize: paddingMin * 0.85,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: paddingMin),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingMin - 5),
          child: TextField(
            controller: widget.controller,
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
              counterText: '',
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
            maxLength: widget.maxLength,
            inputFormatters: inputFormatters,
            keyboardType:
                widget.isNumeric ? TextInputType.number : TextInputType.text,
            obscureText: widget.obscureText && _obscureText,
          ),
        )
      ],
    );
  }
}
