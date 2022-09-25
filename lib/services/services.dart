// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Services {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User user = auth.currentUser!;

  static Future<User?> signUp(
      String nomorhp, String password, String nama) async {
    try {
      final key = Key.fromLength(32);
      final iv = IV.fromLength(16);

      final encrypter = Encrypter(AES(key));
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: '$nomorhp@mamaina.com', password: password);
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
            "password": encrypter.encrypt(password, iv: iv).base64,
            "createdAt": DateTime.now()
          })
          .then(
            (value) => print('User berhasil ditambah'),
          )
          .catchError(
            (error) => print('User gagal ditambahkan $error'),
          );
      return firebaseUser;
    } catch (e) {
      print(e.toString());
    }
  }
}
