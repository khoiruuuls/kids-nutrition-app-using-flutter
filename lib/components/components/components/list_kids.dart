// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import '../../../config/config_size.dart';
import '../../../pages/details/kid_page.dart';

class ListKids extends StatelessWidget {
  final String textName;
  final String textNik;
  final String id;
  const ListKids({
    required this.id,
    required this.textNik,
    required this.textName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: paddingMin / 2),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KidPage(
                  id: id,
                ),
              ),
            )
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(paddingMin),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingMin,
                vertical: paddingMin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade300,
                        radius: 30.0,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade100,
                          size: 25.0,
                        ),
                      ),
                      SizedBox(width: paddingMin),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textName,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: paddingMin / 4),
                          Text(
                            textNik,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
