import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget defaultFormField({
  required String key,
  String? labelText,
  String? hintText,
  String? Function(String?)? validator,
  TextInputAction? textInputAction,
  void Function()? onEditingComplete,
  TextInputType? keyboardType,
  Icon? prefixIcon,
  Color? fillColor,
  void Function(String?)? onSaved,
  bool obscureText = true,
  Widget? suffixIcon,
  FocusNode? focusNode,
  int maxLines = 1,
  List<TextInputFormatter>? inputFormatters,
  TextEditingController? controller,
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
      prefixIcon: prefixIcon,
      labelText: labelText,
      fillColor: fillColor,
      suffixIcon: suffixIcon,
      hintText: hintText,
    ),
    controller: controller,
    inputFormatters: inputFormatters,
    obscureText: suffixIcon == null ? false : obscureText,
    onSaved: onSaved,
    focusNode: focusNode,
    textAlign: TextAlign.start,
    maxLines: maxLines,
  );
}
