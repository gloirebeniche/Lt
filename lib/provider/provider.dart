// Importations des modules
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lt/couleurs/colors.dart';

// Définition de la classe UiProvider
class UiProvider extends ChangeNotifier {

  // ignore: non_constant_identifier_names
  bool _is_dark = false;
  bool get isDark => _is_dark;

  late SharedPreferences storage;

  final darkTheme = ThemeData(
    primaryColor: couleur_16,

    primaryColorDark: couleur_16,

    splashColor: couleur_6,

    appBarTheme: const AppBarTheme(
      backgroundColor: couleur_6,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: couleur_6,
      selectedItemColor: couleur_3,
      unselectedItemColor: couleur_3,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(couleur_16),
      trackColor: MaterialStateProperty.all(couleur_6),
      trackOutlineColor: MaterialStateProperty.all(couleur_6),
    ),

    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontFamily: "Poppins",
        color: couleur_3,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),

      bodyText2: TextStyle(
        fontFamily: "Poppins",
        color: couleur_3,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),

    brightness: Brightness.dark,

  );

  final lightTheme = ThemeData(

    primaryColor: couleur_3,

    primaryColorDark: couleur_3,

    splashColor: couleur_6,

    appBarTheme: const AppBarTheme(
      backgroundColor: couleur_6,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: couleur_6,
      selectedItemColor: couleur_3,
      unselectedItemColor: couleur_3,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(couleur_16),
      trackColor: MaterialStateProperty.all(couleur_3),
      trackOutlineColor: MaterialStateProperty.all(couleur_14),
    ),

    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontFamily: "Poppins",
        color: couleur_9,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),

      bodyText2: TextStyle(
        fontFamily: "Poppins",
        color: couleur_9,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),

    brightness: Brightness.light,

  );

  changeTheme() {
    _is_dark = !_is_dark;
    storage.setBool("isDark", _is_dark);
    notifyListeners();
  }

  init() async {

    storage = await SharedPreferences.getInstance();
    _is_dark = storage.getBool("isDark")?? false;
    notifyListeners();
  }
}