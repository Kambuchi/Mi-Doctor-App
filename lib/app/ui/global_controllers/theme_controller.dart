import '../../domain/repositories/preferences_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

const Map<int, Color> swatch = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

const primaryDarkColor = Color(0xff004c98);
const secondaryDarkColor = Color(0xffd90505);
const primaryLigthColor = Color(0xff005998);

class ThemeController extends SimpleNotifier {
  late ThemeMode _mode;
  ThemeController() {
    _mode = _preference.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
  final PreferenceRepository _preference = Get.i.find();
  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        backgroundColor: primaryDarkColor,
      ),
      scaffoldBackgroundColor: const Color(0x0f000000),
      primaryColorDark: primaryDarkColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryDarkColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(primaryDarkColor.value, swatch),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryDarkColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        brightness: Brightness.light,
        backgroundColor: primaryLigthColor,
      ),
      primaryColorLight: primaryLigthColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryLigthColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(primaryLigthColor.value, swatch),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryLigthColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void toggle() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      _preference.darkMode(true);
    } else {
      _mode = ThemeMode.light;
      _preference.darkMode(false);
    }
    notify();
  }
}

final themeProvider = SimpleProvider(
  (_) => ThemeController(),
  autoDispose: false,
);
