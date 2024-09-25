import 'package:flutter/material.dart';
import 'package:virtual_marketplace/themes/theme_colors.dart';

ThemeData theme = ThemeData(
  useMaterial3: false,
  primaryColor: ThemeColors.primary,
  scaffoldBackgroundColor: ThemeColors.primary,
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeColors.primary,
    elevation: 0,
  )
  // colorScheme: ColorScheme.fromSwatch(
  //   primarySwatch: ThemeColors.primary,
  //   brightness: Brightness.dark,
  // ),
  // textTheme: const TextTheme(
  //   bodyMedium: TextStyle(fontSize: 16),
  //   bodyLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  // ),
  // fontFamily: 'Raleway',
);