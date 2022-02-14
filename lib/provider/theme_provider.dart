import 'package:ecommerce/network/local/shared_prefrence.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = false;
  bool get getTheme => isDark;
  set darkTheme(bool value) {
    isDark = value;
    SharedPref.saveData(value: isDark,key: 'isDark');
    notifyListeners();
  }
}
