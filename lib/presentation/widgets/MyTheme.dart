import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class MyTheme extends ChangeNotifier {
  static bool _isDark = (ThemeMode.system == ThemeMode.dark);
  static bool _manually = false;
  static ColorScheme _colorsheme = ColorScheme.dark();

  Color getBackroungColorIcon() {
    return _isDark ? Colors.black : Colors.white;
  }

  bool getisDark() {
    return _isDark;
  }

  ThemeMode currentTheme() {
    if (_manually == false) {
      return ThemeMode.system;
    } else {
      return _isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void switchTheme() {
    _manually = true;
    _isDark = !_isDark;
    _colorsheme = ColorScheme.light();
    notifyListeners();
  }
}
