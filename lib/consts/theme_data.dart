import 'package:flutter/material.dart';

class Styles {
  static ThemeData lightTheme({required BuildContext context}) {
    return ThemeData(
      
      scaffoldBackgroundColor: Colors.grey.shade300,
      primarySwatch: Colors.purple,
      primaryColor: Colors.grey.shade300,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xffCBDCF8),
      hintColor: Colors.grey.shade800,
      highlightColor: const Color(0xffFCE192),
      hoverColor: const Color(0xff4285F4),
      focusColor: const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.black,
      ),
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.light()),
      appBarTheme:  AppBarTheme(
        iconTheme: IconThemeData(
          color: Theme.of(context).textSelectionTheme.selectionColor,
        ) ,
        elevation: 0.0,
        
      ),
    );
  }

  static ThemeData darkTheme({required BuildContext context}) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      
      primarySwatch: Colors.purple,
      primaryColor: Colors.black,
      backgroundColor: Colors.grey.shade700,
      indicatorColor: const Color(0xff0E1D36),
      hintColor: Colors.grey.shade300,
      highlightColor: const Color(0xff372901),
      hoverColor: const Color(0xff3A3A3B),
      focusColor: const Color(0xff0B2512),
      disabledColor: Colors.grey,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.white,
      ),
      cardColor: const Color(0xFF151515),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: const ColorScheme.dark(),
          ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Colors.purple,
      ),
    );
  }
}
