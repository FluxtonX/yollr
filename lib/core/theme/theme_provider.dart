// lib/core/theme/theme_provider.dart

import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData.brightness == Brightness.light) {
      setTheme(ThemeData.dark(useMaterial3: true));
    } else {
      setTheme(AppTheme.lightTheme);
    }
  }
}
