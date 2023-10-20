import 'package:flutter/material.dart';

void showSnackMessage(BuildContext context,
    {required String message, Color? backgroundColor, Color? tcolor}) {
  final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(color: tcolor),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
