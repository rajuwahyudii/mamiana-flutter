// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamiana/pages/menu.dart';
import 'package:mamiana/services/services.dart';
import 'package:mamiana/theme/color.dart';

class Upload extends StatefulWidget {
  String id;
  // CollectionReference collectionRef =
  //     FirebaseFirestore.instance.collection('user');
  int day;
  Upload({
    required this.id,
    required this.day,
    Key? key,
  }) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user');
  String? imagePath;
  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String id = widget.id;

    int day = widget.day;
    return FutureBuilder<DocumentSnapshot>(
      future: collectionRef.doc(id).collection("day").doc("day$day").get(),
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
                        builder: (context) => MenuPages(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Hari ke-$day',
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
                            child: (data["status"] == "belum")
                                ? ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isWaiting = true;
                                      });
                                      try {
                                        File file = await getImage();
                                        imagePath = await Services.uploadImage(
                                            id, file, day);

                                        await Services.saveUrl(day, imagePath!)
                                            .then(
                                          (value) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Berhasil Upload Gambar'),
                                            ),
                                          ),
                                        );
                                        setState(() {
                                          isWaiting = false;
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text("Ambil Foto"),
                                  )
                                : SizedBox(
                                    width: size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(17),
                                          child: Text(
                                            data["status"] == "sudah"
                                                ? "status : Laporan Berhasil"
                                                : "status : anda tidak mengirimkan foto",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: data["status"] == "sudah"
                                                  ? signedColor
                                                  : unsignedColor,
                                            ),
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
                  isWaiting == true
                      ? Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : Container()
                ],
              ));
        }
        return Scaffold();
      },
    );
  }
}

Future<File> getImage() async {
  var image = await ImagePicker().pickImage(source: ImageSource.camera);
  return File(image!.path);
}
