import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function press;
  final Color buttonColor, textColor;
  const CustomButtonWidget(
      {required this.text,
      required this.press,
      required this.buttonColor,
      required this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(62),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      // ignore: sort_child_properties_last
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 22,
          color: textColor,
        ),
      ),
      onPressed: press != null
          ? () {
              press();
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: GoogleFonts.poppins(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
