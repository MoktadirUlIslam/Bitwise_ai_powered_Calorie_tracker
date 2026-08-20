import 'package:flutter/material.dart';

class AppColors {
  // --- Background Colors (Extracted from gradient) ---
  /// The dark green color found in the bottom-left and corners.
  static const Color backgroundDark = Color(0xFF2B4A35);

  /// The slightly lighter, brownish-green color found in the top-right.
  static const Color backgroundLight = Color(0xFF5B5B3E);

  // --- Main Element Colors ---
  /// The bright orange/yellow color of the fruit/clock face.
  static const Color fruitOrange = Color(0xFFFCB641);

  /// The dark green circle to the top-right of the fruit.
  static const Color accentDarkGreen = Color(0xFF22432F);

  /// The light green leaf color.
  static const Color leafGreen = Color(0xFFB7D3A7);

  // --- Clock Details ---
  /// The dark brown/grey center dot and hands.
  static const Color clockDetails = Color(0xFF67503B);

  // --- Standard App Usage Helpers ---

  /// Returns a LinearGradient that mimics the background of your image.
  static LinearGradient get backgroundGradient => const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      backgroundDark, // Bottom left (darkest green)
      Color(0xFF3A4F3A), // Middle transition
      backgroundLight, // Top right (brownish)
    ],
  );
}