import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme;
  ThemeProvider({@required ThemeMode currentTheme})
      : _currentTheme = currentTheme;

  ThemeMode get currentTheme => _currentTheme;

  void setCurrentTheme(ThemeMode mode) {
    _currentTheme = mode;
    notifyListeners();
  }

  bool _material3 = true;
  bool get material3 => _material3;

  void setMaterial3(bool value) {
    _material3 = value;
    notifyListeners();
  }
}
