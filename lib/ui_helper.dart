import 'package:flutter/material.dart';

// const Color bgColor = Color(0xFFEEEEF1);

const Color highlightedText = Color(0xFF060609);

const Color greyText = Color(0xFF7C7B83);

// const Color textWColor = Color(0xFFEEEEF1);
// const Color textBColor = Color(0xFF060609);
// Widget boldGreyTextStyle(title) {
//   return Text(
//     title,
//     style: TextStyle(color: greyText, fontSize: 20),
//   );
// }

// boldBlackTextStyle() {
//   return TextStyle(color: textBColor, fontSize: 20);
// }

// boldWhiteTextStyle() {
//   return TextStyle(color: textWColor, fontSize: 20);
// }

class MyColor {
  static const Color bgWColor = Color(0xffffffff);
  static const Color secondaryWColor = Color(0xffF5F4F6);
  static const Color bgBColor = Color(0xff1c1b34);
  static const Color secondaryBColor = Color(0xff55537a);

  static const Color textWColor = Color(0xffffffff);
  static const Color textBColor = Color(0xff000000);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

TextStyle mTextStyle43(
    {fontWeight = FontWeight.normal,
    mColor = Colors.black,
    fontStyle = FontStyle.normal}) {
  return TextStyle(
    fontSize: 43,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: mColor,
    // fontFamily: 'QuickSand'
  );
}

TextStyle mTextStyle52(
    {fontWeight = FontWeight.normal,
    mColor = Colors.black,
    fontStyle = FontStyle.normal}) {
  return TextStyle(
    fontSize: 52,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: mColor,
    // fontFamily: 'QuickSand'
  );
}

TextStyle mTextStyle34(
    {fontWeight = FontWeight.normal,
    mColor = Colors.black,
    fontStyle = FontStyle.normal}) {
  return TextStyle(
    fontSize: 34,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: mColor,
    // fontFamily: 'QuickSand'
  );
}

TextStyle mTextStyle25(
    {fontWeight = FontWeight.normal,
    mColor = Colors.black,
    fontStyle = FontStyle.normal}) {
  return TextStyle(
    fontSize: 25,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: mColor,
    // fontFamily: 'QuickSand'
  );
}

TextStyle mTextStyle16(
    {fontWeight = FontWeight.normal,
    mColor = Colors.black,
    fontStyle = FontStyle.normal}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: mColor,
    // fontFamily: 'QuickSand'
  );
}

TextStyle mTextStyle12(
    {fontWeight = FontWeight.normal,
    mColor = Colors.black,
    fontStyle = FontStyle.normal}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: mColor,
    // fontFamily: 'QuickSand'
  );
}
