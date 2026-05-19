// lib/constants/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color darkBlue = Color(0xFF1A2B4A);
  static const Color primaryContainer = Color(0xFF3D5AFE);
  static const Color primary = Color(0xFF2979FF);
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color secondaryCream = Color(0xFFF5F6FA);
  static const Color cardWhite = Colors.white;
}

ThemeData appTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryContainer,
      background: AppColors.secondaryCream,
    ),
    scaffoldBackgroundColor: AppColors.secondaryCream,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    useMaterial3: true,
  );
}
