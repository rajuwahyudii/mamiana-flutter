// ignore_for_file: unused_label

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamiana/pages/home.dart';
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
  Whatsapp whatsapp = Whatsapp();
  @override
  void initState() {
    whatsapp.setup(
      accessToken: 'cXnwup67hgj3QdvpXXXXX==',
      fromNumberId: 1800000000000,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('user');

    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: collectionRef.doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
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
                          color:
                          data["hari"] >= day
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Upload(
                                      id: user.uid,
                                      day: day,
                                    ),
                                  ),
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Anda masih di hari ke ${data["hari"]} dalam jadwal minum obat"),
                                  ),
                                );
                        },
                        child: Container(
                          width: size.width * 0.3,
                          height: size.height * 0.15,
                          decoration: BoxDecoration(
                            color: data["hari"] >= day
                                ? signedColor
                                : notTodayColor,
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
          return Scaffold();
        });
  }
}
