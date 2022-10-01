// ignore_for_file: avoid_print, body_might_complete_normally_nullable

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';

class Services {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User user = auth.currentUser!;

  // Login
  static Future<User?> signIn(String nomorhp, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: '$nomorhp@mamiana.com', password: password);
      User? firebaseUser = result.user;
      return firebaseUser;
    } catch (e) {
      print('e');
    }
  }

// Logout
  static Future<User?> signOut() async {
    await auth.signOut();
  }

  static Stream<User?> get FirebaseUserStream => auth.authStateChanges();

  //register
  static Future<User?> signUp(
      String nomorhp, String password, String nama) async {
    try {
      final key = Key.fromLength(32);
      final iv = IV.fromLength(16);

      final encrypter = Encrypter(AES(key));
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: '$nomorhp@mamiana.com', password: password);
      User idreg = auth.currentUser!;

      User? firebaseUser = result.user;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(idreg.uid)
          .set({
            "id": idreg.uid,
            "role": "user",
            "nama": nama,
            "email": '$nomorhp@gmail.com',
            'nomorhp': nomorhp,
            "hari": 1,
            "password": encrypter.encrypt(password, iv: iv).base64,
            "createdAt": DateTime.now()
          })
          .then(
            (value) => print('User berhasil ditambah'),
          )
          .catchError(
            (error) => print('User gagal ditambahkan $error'),
          );
      for (int i = 1; i < 31; i++) {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(idreg.uid)
            .collection("day")
            .doc("day$i")
            .set({
          "url": "",
          "status": "belum",
        });
      }
      return firebaseUser;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> uploadImage(String id, File imageFile, int day) async {
    String fileName = basename("$id-day$day");
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = ref.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    return await snapshot.ref.getDownloadURL();
  }

  static Future<User?> saveUrl(
    int index,
    String url,
  ) async {
    User idreg = auth.currentUser!;
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(idreg.uid)
          .collection("day")
          .doc("day$index")
          .update({
        'url': url,
        'status': 'sudah',
      });
    } catch (e) {
      print(e);
    }
  }
}
