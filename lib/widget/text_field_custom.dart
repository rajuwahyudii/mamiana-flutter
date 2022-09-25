import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCustomWidget extends StatelessWidget {
  final TextStyle? matchColor;
  final Function visibility;
  final String? notMatch;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboard;
  final String label;
  final bool obsuretext;
  final ValueChanged<String>? onChanged;
  const TextFieldCustomWidget({
    this.matchColor,
    this.notMatch,
    required this.isPassword,
    required this.visibility,
    required this.obsuretext,
    required this.controller,
    required this.keyboard,
    required this.label,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: 4 / 5 * size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextFormField(
            keyboardType: keyboard,
            controller: controller,
            obscureText: obsuretext,
            onChanged: onChanged,
            decoration: InputDecoration(
              floatingLabelAlignment: FloatingLabelAlignment.center,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              alignLabelWithHint: true,
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              suffixIcon: isPassword == true
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: (obsuretext == true) ? Colors.grey : Colors.blue,
                      ),
                      onPressed: () {
                        visibility();
                      },
                    )
                  : null,
              fillColor: Colors.white70,
              filled: true,
            ),
          ),
          Text(
            notMatch != null ? notMatch! : '',
            style: matchColor,
          )
        ],
      ),
    );
  }
}
