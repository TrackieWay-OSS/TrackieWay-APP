import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Tema de Alto Contraste Claro
  static ThemeData get highContrastLightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.black,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Tema de Alto Contraste Escuro
  static ThemeData get highContrastDarkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
       appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
        error: Colors.yellow,
        onError: Colors.black,
        background: Colors.black,
        onBackground: Colors.white,
      ),
       textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}