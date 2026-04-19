import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF8C00);

  static Color backgroundAccent = const Color(0xFFEDEDED);
 
  static Color textPrimary = const Color(0xFF212121);
  static Color textSecondary = const Color(0xFF757575);
  static Color inactive = const Color(0xFFD9D9D9);

  static Color textWhite = const Color(0xFFFFFFFF);
}
  
///
/// Definition of App text styles.
///
class AppTextStyles {
  static TextStyle heading = TextStyle(fontSize: 28, fontWeight: FontWeight.w500);

  static TextStyle body =  TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle label =  TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle button =  TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
}



///
/// Definition of App spacings, in pixels.
/// Bascially small (S), medium (m), large (l), extra large (x), extra extra large (xxl)
///
class AppSpacings {
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16; 
  static const double l = 24; 
  static const double xl = 32; 
  static const double xxl = 40; 

  static const double radius = 16; 
  static const double radiusLarge = 24; 
}

ThemeData kleanTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: AppColors.backgroundAccent,
);
 