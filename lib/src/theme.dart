import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final theme = ThemeData(
  primaryColor: HexColor("#11544D"),
  colorScheme: ColorScheme(
    primary: HexColor("#11544D"),
    secondary: HexColor("#11544D"),
    surface: HexColor("#FFFFFF"),
    background: HexColor("#FFFFFF"),
    error: Colors.red,
    onPrimary: HexColor("#FFFFFF"),
    onSecondary: HexColor("#FFFFFF"),
    onSurface: HexColor("#80D995"),
    onBackground: HexColor("#80D995"),
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
