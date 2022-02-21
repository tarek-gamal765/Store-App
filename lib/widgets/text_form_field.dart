import 'package:flutter/material.dart';

Widget defaultFormField({
  required String key,
  required String labelText,
  String? Function(String?)? validator,
  TextInputAction? textInputAction,
  void Function()? onEditingComplete,
  TextInputType? keyboardType,
  IconData? prefixIcon,
  Color? fillColor,
  void Function(String?)? onSaved,
  bool obscureText = true,
  Widget? suffixIcon,
  FocusNode? focusNode,
}) {
  return TextFormField(
    key: ValueKey(key),
    validator: validator,
    textInputAction: textInputAction,
    onEditingComplete: onEditingComplete,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      border: const UnderlineInputBorder(),
      filled: true,
      prefixIcon: Icon(prefixIcon),
      labelText: labelText,
      fillColor: fillColor,
      suffixIcon: suffixIcon,
      
    ),
    obscureText: suffixIcon == null ? false : obscureText,
    onSaved: onSaved,
    focusNode: focusNode,
  );
}
