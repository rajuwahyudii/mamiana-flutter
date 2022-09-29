import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamiana/services/services.dart';

class Upload extends StatefulWidget {
  int day;
  Upload({
    required this.day,
    Key? key,
  }) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int day = widget.day;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hari ke-$day',
          style: GoogleFonts.poppins(
            fontSize: 17,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (imagePath != null)
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  File file = await getImage();
                  imagePath = await Services.uploadImage(file);

                  setState(() {});
                },
                child: Text('a'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Future<File> getImage() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return File(image!.path);
}
