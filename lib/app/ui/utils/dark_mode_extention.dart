import 'package:flutter/material.dart';

extension DarkModeExtention on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
