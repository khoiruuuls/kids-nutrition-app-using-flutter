// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config_size.dart';
import '../services/counter_service.dart';

class ComponentsCounter extends StatefulWidget {
  const ComponentsCounter({super.key});

  @override
  State<ComponentsCounter> createState() => _ComponentsCounterState();
}

class _ComponentsCounterState extends State<ComponentsCounter> {
  final Counter counter = Counter();

  void increamentCounter() {
    setState(() {
      counter.increment();
    });
  }

  void decreamentCounter() {
    setState(() {
      counter.decrement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingMin * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: decreamentCounter,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Container(
              child: Text(
                counter.value.toString(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: increamentCounter,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.grey.shade400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
