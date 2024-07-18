import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;

    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  ThemeData get _lightTheme => ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      );

  ThemeData get _darkTheme => ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      );
}
