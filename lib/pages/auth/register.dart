import 'package:flutter/material.dart';
import 'package:mamiana/pages/auth/login.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: SafeArea(
          child: SizedBox(
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
                    password != false ? password = false : password = true;
                  });
                },
                obsuretext: password,
                controller: passwordController,
                keyboard: TextInputType.number,
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
                keyboard: TextInputType.number,
                label: 'Konfirmasi Kata Sandi',
                notMatch: konfirmasipasswordController.text == ''
                    ? ('')
                    : (konfirmasipasswordController.text ==
                            passwordController.text
                        ? 'kata sandi sesuai'
                        : 'kata sandi tidak sesuai'),
                matchColor:
                    konfirmasipasswordController.text == passwordController.text
                        ? matchTextStyle
                        : notmatchTextStyle,
              ),
              CustomButtonWidget(
                text: 'Register',
                press: () {
                  Services.signUp(
                    nomorHPController.text,
                    passwordController.text,
                    namaController.text,
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
