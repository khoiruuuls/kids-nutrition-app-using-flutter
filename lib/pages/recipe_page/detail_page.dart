// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/components_back.dart';
import '../../config/config_size.dart';
import '../../services/counter_service.dart';
import '../../services/firestore.dart';
import 'fullscreen_slider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  FirestoreService firestoreService = FirestoreService();

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
    ConfigSize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ConfigSize.blockSizeVertical! * 50,
                child: Stack(
                  children: [
                    FullscreenSlider(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(paddingMin * 3),
                            topRight: Radius.circular(paddingMin * 3),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ComponentsBack(
                      textTitle: "Detail",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingMin * 2),
                child: Text(
                  "Unravel mystery of the Maldives",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: paddingMin * 2,
                  vertical: paddingMin,
                ),
                padding: EdgeInsets.all(paddingMin),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(paddingMin),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: decreamentCounter,
                      child: Container(
                        height: 40,
                        width: 40,
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
                    SizedBox(width: ConfigSize.blockSizeHorizontal! * 3),
                    Text(
                      counter.value.toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: ConfigSize.blockSizeHorizontal! * 3),
                    GestureDetector(
                      onTap: increamentCounter,
                      child: Container(
                        height: 40,
                        width: 40,
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
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: paddingMin * 2,
                  vertical: paddingMin,
                ),
                padding: EdgeInsets.all(paddingMin),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(paddingMin),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: paddingMin * 2,
                      backgroundImage: NetworkImage(
                          'https://getillustrations.b-cdn.net//photos/pack/3d-avatar-male_lg.png'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Khoirul Fahmi",
                          style: GoogleFonts.poppins(),
                        ),
                        SizedBox(height: paddingMin / 10),
                        Text(
                          "23 January 2023, 8 mins read",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingMin * 2),
                child: Text(
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                  style: GoogleFonts.poppins(),
                ),
              ),
              SizedBox(height: paddingMin * 2)
            ],
          ),
        ),
      ),
    );
  }
}
