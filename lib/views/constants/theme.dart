import 'package:flutter/material.dart';

import 'colors.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.black,
  canvasColor: kWhitebgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kWhitebgColor,
    foregroundColor: kBlackbgColor,
    elevation: 0.0,
  ),
);
final darkTheme = ThemeData(
  primaryColor: Colors.white,
  canvasColor: kBlackbgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kBlackbgColor,
    foregroundColor: kWhitebgColor,
    elevation: 0.0,
  ),
);
