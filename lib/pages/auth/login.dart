// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:mamiana/pages/auth/register.dart';
import 'package:mamiana/pages/wrapper.dart';
import 'package:mamiana/services/services.dart';
import 'package:mamiana/theme/color.dart';
import 'package:mamiana/theme/textstyle.dart';
import 'package:mamiana/widget/button_custom.dart';
import 'package:mamiana/widget/text_field_custom.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nomorHPController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  bool password = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldCustomWidget(
                isPassword: false,
                obsuretext: false,
                controller: nomorHPController,
                keyboard: TextInputType.number,
                label: 'Nomor HP',
                visibility: () {},
              ),
              TextFieldCustomWidget(
                  isPassword: true,
                  obsuretext: password,
                  controller: passwordController,
                  keyboard: TextInputType.name,
                  label: 'Kata Sandi',
                  visibility: () {
                    setState(() {
                      password != false ? password = false : password = true;
                    });
                  }),
              CustomButtonWidget(
                text: 'Login',
                press: () async {
                  await Services.signIn(
                          nomorHPController.text, passwordController.text)
                      .then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            value != null ? "Login Berhasil" : "Login Gagal"),
                      ),
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Wrapper()),
                    ),
                  );
                },
                buttonColor: Colors.white,
                textColor: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum memiliki akun?',
                    style: registeandloginTextStyle,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      child: Text(
                        'Registrasi',
                        style: linkTextStyle,
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
