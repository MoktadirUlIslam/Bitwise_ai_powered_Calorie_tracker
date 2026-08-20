// lib/utils/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // --- Background Colors ---
  static const Color backgroundDark = Color(0xFF2B4A35);
  static const Color backgroundLight = Color(0xFF5B5B3E);

  // --- Main Element Colors ---
  static const Color fruitOrange = Color(0xFFFCB641);
  static const Color accentDarkGreen = Color(0xFF22432F);
  static const Color leafGreen = Color(0xFFB7D3A7);

  // --- Clock Details ---
  static const Color clockDetails = Color(0xFF67503B);

  // --- SnackBar Colors (Using App Theme) ---
  static const Color snackbarSuccess = Color(0xFF2E7D32);
  static const Color snackbarError = Color(0xFFC62828);
  static const Color snackbarWarning = Color(0xFFE65100);
  static const Color snackbarInfo = Color(0xFF0D47A1);

  // --- Text Colors ---
  static const Color textWhite = Colors.white;
  static const Color textDark = Color(0xFF2B4A35);

  // --- Standard App Usage Helpers ---
  static LinearGradient get backgroundGradient => const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      backgroundDark,
      Color(0xFF3A4F3A),
      backgroundLight,
    ],
  );
}