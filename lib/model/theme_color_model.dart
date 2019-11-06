import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColorModel with ChangeNotifier {
  String _themeColor;

  void changeThemeColor(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }

  String get themeColor => _themeColor;
}
