import 'package:flutter/material.dart';

Widget defaultDivider({EdgeInsetsGeometry? padding}) {
  return  Padding(
    padding:  padding ?? EdgeInsets.zero,
    child:  const Divider(
      color: Colors.grey,
      thickness: 1,
      height: 1,

    ),
  );
}
