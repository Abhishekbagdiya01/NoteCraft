import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  CustomLogo(
      {super.key, required this.isLight, this.height, this.width, this.radius});

  final bool isLight;
  double? height = 150;
  double? width = 150;
  double? radius = 100;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
      radius: radius,
      child: Image.asset(
        "assets/images/NoteCraft_logo.png",
        height: height,
        width: width,
      ),
    );
  }
}
