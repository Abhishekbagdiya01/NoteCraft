import 'package:flutter/material.dart';

void customSnackbarMessenger(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
