import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamiana/pages/report.dart';
import 'package:mamiana/theme/color.dart';

class DataPages extends StatefulWidget {
  int day;
  String id;
  DataPages({
    required this.id,
    required this.day,
    Key? key,
  }) : super(key: key);

  @override
  State<DataPages> createState() => _DataPagesState();
}

class _DataPagesState extends State<DataPages> {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: collectionRef
            .doc(widget.id)
            .collection("day")
            .doc("day${widget.day}")
            .get(),
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
                          builder: (context) => Report(id: widget.id),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    'Hari ke-${widget.day}',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    SafeArea(
                      child: SizedBox(
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            (data["url"] != null)
                                ? Container(
                                    width: size.width * 0.7,
                                    height: size.height * 0.4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(data["url"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: size.width * 0.7,
                                    height: size.height * 0.4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            Container(
                              child: SizedBox(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(17),
                                      child: Text(
                                        data["status"] == "sudah"
                                            ? "status : Pasien Mengirimkan Foto"
                                            : data["status"] == 'belum'
                                                ? "status : Pasien Belum Mengirimkan Foto"
                                                : "status : Pasien Tidak Mengirimkan Foto",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: data["status"] == "sudah"
                                                ? signedColor
                                                : data["status"] == 'belum'
                                                    ? notTodayColor
                                                    : unsignedColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          }
          return Scaffold();
        });
  }
}
