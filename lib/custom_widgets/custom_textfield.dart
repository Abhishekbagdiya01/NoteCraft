import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.controller,
      required this.color,
      this.hintText,
      this.icon,
      this.textInputType,
      this.suffixIcon,
      this.voidCallback,
      this.obscureText = false});

  final TextEditingController controller;
  IconData? icon;
  String? hintText;
  Color color;
  TextInputType? textInputType;
  IconData? suffixIcon;
  VoidCallback? voidCallback;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: mTextStyle25(),
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: mTextStyle16(mColor: color.withOpacity(.5)),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        suffixIcon: InkWell(
          onTap: voidCallback,
          child: Icon(
            suffixIcon,
            color: color,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: UnderlineInputBorder(),
      ),
    );
  }
}
