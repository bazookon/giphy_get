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
}
