import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  setTheme(bool newTheme) {
    _darkTheme = newTheme;
    notifyListeners();
  }
}

class ThemeApplier {
  Color backgroundColor;
  Color backgroundColor2;
  Color navBar;
  Color primaryShadow;
  Color shimmerColor;
  ThemeApplier({
    required this.backgroundColor,
    required this.backgroundColor2,
    required this.navBar,
    required this.primaryShadow,
    required this.shimmerColor,
  });
}
