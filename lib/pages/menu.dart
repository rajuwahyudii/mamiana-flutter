import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamiana/pages/upload.dart';
import 'package:mamiana/services/services.dart';
import 'package:mamiana/theme/color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp/whatsapp.dart';

class MenuPages extends StatefulWidget {
  MenuPages({Key? key}) : super(key: key);

  @override
  State<MenuPages> createState() => _MenuPagesState();
}

class _MenuPagesState extends State<MenuPages> {
  @override
  Whatsapp whatsapp = Whatsapp();
  void initState() {
    whatsapp.setup(
      accessToken: 'cXnwup67hgj3QdvpXXXXX==',
      fromNumberId: 1800000000000,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Services.signOut();
          },
        ),
        title: const Text("Menu"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(30, (index) {
            int day = index + 1;
            return Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Upload(
                        day: day,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    color: signedColor,
                    borderRadius: BorderRadius.circular(
                      17,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Hari ke -$day',
                      style: GoogleFonts.poppins(
                          fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
