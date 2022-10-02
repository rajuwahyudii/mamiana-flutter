import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamiana/pages/admin.dart';
import 'package:mamiana/pages/data.dart';
import 'package:mamiana/pages/home.dart';
import 'package:mamiana/pages/upload.dart';
import 'package:mamiana/theme/color.dart';

class Report extends StatefulWidget {
  String id;
  Report({required this.id, Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: collectionRef.doc(widget.id).get(),
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
                        builder: (context) => AdminPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                title: const Text("Laporan"),
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
                                builder: (context) => DataPages(
                                      id: widget.id,
                                      day: day,
                                    )),
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
                              'Hari ke $day',
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
