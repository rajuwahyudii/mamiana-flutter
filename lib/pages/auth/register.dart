// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mamiana/pages/auth/login.dart';
import 'package:mamiana/pages/wrapper.dart';
import 'package:mamiana/services/services.dart';
import 'package:mamiana/theme/color.dart';
import 'package:mamiana/theme/textstyle.dart';
import 'package:mamiana/widget/button_custom.dart';
import 'package:mamiana/widget/text_field_custom.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController namaController = TextEditingController(text: "");
  TextEditingController nomorHPController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController konfirmasipasswordController =
      TextEditingController(text: "");
  bool password = true;
  bool konfirmasipassword = true;
  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFieldCustomWidget(
                      isPassword: false,
                      visibility: () {},
                      obsuretext: false,
                      controller: namaController,
                      keyboard: TextInputType.name,
                      label: 'Nama',
                    ),
                    TextFieldCustomWidget(
                      isPassword: false,
                      visibility: () {},
                      obsuretext: false,
                      controller: nomorHPController,
                      keyboard: TextInputType.number,
                      label: 'Nomor HP',
                    ),
                    TextFieldCustomWidget(
                      isPassword: true,
                      visibility: () {
                        setState(() {
                          password != false
                              ? password = false
                              : password = true;
                        });
                      },
                      obsuretext: password,
                      controller: passwordController,
                      keyboard: TextInputType.name,
                      label: 'Kata Sandi',
                    ),
                    TextFieldCustomWidget(
                      isPassword: true,
                      visibility: () {
                        setState(() {
                          konfirmasipassword != false
                              ? konfirmasipassword = false
                              : konfirmasipassword = true;
                        });
                      },
                      obsuretext: konfirmasipassword,
                      controller: konfirmasipasswordController,
                      keyboard: TextInputType.name,
                      label: 'Konfirmasi Kata Sandi',
                      notMatch: konfirmasipasswordController.text == ''
                          ? ('')
                          : (konfirmasipasswordController.text ==
                                  passwordController.text
                              ? 'kata sandi sesuai'
                              : 'kata sandi tidak sesuai'),
                      matchColor: konfirmasipasswordController.text ==
                              passwordController.text
                          ? matchTextStyle
                          : notmatchTextStyle,
                    ),
                    CustomButtonWidget(
                      text: 'Register',
                      press: passwordController.text ==
                              konfirmasipasswordController.text
                          ? () async {
                              setState(() {
                                isWaiting = true;
                              });
                              await Services.signUp(
                                nomorHPController.text,
                                passwordController.text,
                                namaController.text,
                              ).then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(value != null
                                        ? "Register Berhasil"
                                        : "Register Gagal"),
                                  ),
                                ),
                              );
                              setState(() {
                                isWaiting = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Wrapper(),
                                ),
                              );
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("password tidak sesuai"),
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
                          'Sudah memiliki akun?',
                          style: registeandloginTextStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: linkTextStyle,
                          ),
                        ),
                      ],
                    )
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
        ),
      ),
    );
  }
}
