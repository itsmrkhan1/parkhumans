import 'package:flutter/material.dart';

ThemeData LightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade800,
  ),
textTheme: ThemeData.light().textTheme.apply(
  bodyColor: Colors.grey[800],
  displayColor: Colors.black,
),
);