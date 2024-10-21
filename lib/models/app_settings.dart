import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool _isDarkMode = true; // Default is dark mode
  Locale _appLocale = Locale('en'); // Default language

  bool get isDarkMode => _isDarkMode;
  Locale get appLocale => _appLocale;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }
}
