import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
