import 'package:flutter/material.dart';

Widget defaultOutlinedButton({
  required String text,
  required Color borderColor,
  required VoidCallback onPressed,
  required Color textColor,
}) {
  return OutlinedButton(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        BorderSide(
          width: 2,
          color: borderColor,
        ),
      ),
      shape: MaterialStateProperty.all(
        const StadiumBorder(),
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.deepPurple.shade200,
      ),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style:  TextStyle(
        color: textColor,
      ),
    ),
  );
}
