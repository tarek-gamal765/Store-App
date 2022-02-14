import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextButton({
  required String text,
  required VoidCallback onPressed,
   TextStyle? textStyle,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: textStyle,
    ),
  );
}
