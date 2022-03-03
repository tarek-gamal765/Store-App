import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget customFlushBar({
  required BuildContext context,
  required String message,
  required String title,
  required backgroundColor,
}) =>
    Flushbar(
      message: message,
      backgroundColor: backgroundColor,
      title: title,
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
      forwardAnimationCurve: Curves.fastOutSlowIn,
    )..show(context);
