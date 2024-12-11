import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData get lightTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.grey,
      ),
      useMaterial3: true,
    ).copyWith(
      dividerTheme: const DividerThemeData(space: 24),
      chipTheme: const ChipThemeData(
        shape: StadiumBorder(
          side: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
