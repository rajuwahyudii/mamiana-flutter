import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mamiana/pages/wrapper.dart';
import 'package:mamiana/theme/color.dart';
import 'package:mamiana/theme/textstyle.dart';
import 'auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashTimer();
    super.initState();
  }

  Future<Timer> splashTimer() async {
    return Timer(const Duration(seconds: 4), onDone);
  }

  void onDone() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Wrapper(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   'assets/images/splash.png',
            //   width: 341.54,
            // ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Mamiana',
              style: splashTextStyle,
              textScaleFactor: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'APLIKASI PENGETAHUAN STUNTING',
              textAlign: TextAlign.center,
              style: splash2TextStyle,
              textScaleFactor: 1,
            ),
          ],
        )),
      ),
    );
  }
}
