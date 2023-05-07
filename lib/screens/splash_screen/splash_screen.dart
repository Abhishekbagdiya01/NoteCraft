import 'dart:async';

import 'package:firebase_note_app/custom_widgets/custom_logo.dart';
import 'package:firebase_note_app/screens/user_onboarding/sign_up/sign_up_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? MyColor.bgWColor : MyColor.bgBColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(
              isLight: isLight,
              radius: 100,
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "NoteCraft",
              style: mTextStyle25(
                  mColor: isLight ? MyColor.bgBColor : MyColor.bgWColor),
            )
          ],
        ),
      ),
    );
  }
}
