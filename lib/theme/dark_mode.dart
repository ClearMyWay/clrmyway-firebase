import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      inversePrimary: Colors.grey.shade500),
  textTheme: ThemeData.light()
      .textTheme
      .apply(bodyColor: Colors.grey[800], displayColor: Colors.black),
);
