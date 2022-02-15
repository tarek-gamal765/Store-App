import 'package:flutter/material.dart';

Widget defaultButton({
  double? height,
  double? width,
  required Color color,
  double? borderRadius,
  required String text,
  TextStyle? textStyle,
  required Function()? onPressed,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      color: color,
    ),
    clipBehavior: Clip.antiAlias,
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    ),
  );
}
