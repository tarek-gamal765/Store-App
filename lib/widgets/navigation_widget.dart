import 'package:flutter/material.dart';

Future<dynamic> navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
