// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mamiana/pages/auth/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mamiana/pages/auth/register.dart';
import 'package:mamiana/pages/splashscreen.dart';
import 'package:mamiana/pages/wrapper.dart';
import 'package:mamiana/services/services.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "mamaina.env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future<int> storagePermissionChecker;
    // Future<int> checkStoragePermission() async {
    //   final result = await PermissionHandler().checkPermissionStatus();
    // }

    return StreamProvider.value(
      value: Services.FirebaseUserStream,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
