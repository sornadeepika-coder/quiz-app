import 'package:flutter/material.dart';

/// Centralized app theme definitions providing consistent colors,
/// typography, and elevation across the Quiz application.
class AppTheme {
  AppTheme._();

  // Color Palette: Blue, White, and Light Background
  static const Color primaryBlue = Color(0xFF2563EB); // Vibrant Royal Blue
  static const Color primaryDark = Color(0xFF1D4ED8); // Deep Blue
  static const Color primaryLight = Color(0xFFEFF6FF); // Soft blue tint
  static const Color primarySurface = Color(0xFFDBEAFE); // Border/accent blue
  
  static const Color backgroundLight = Color(0xFFF8FAFC); // Clean light background
  static const Color cardBackground = Colors.white; // Pure white card
  
  // Feedback Colors
  static const Color correctGreen = Color(0xFF16A34A); // Forest Green
  static const Color correctLight = Color(0xFFDCFCE7); // Light green background
  static const Color correctBorder = Color(0xFF22C55E); // Green border
  
  static const Color wrongRed = Color(0xFFDC2626); // Crimson Red
  static const Color wrongLight = Color(0xFFFEE2E2); // Light red background
  static const Color wrongBorder = Color(0xFFEF4444); // Red border

  // Text & Neutral Colors
  static const Color textDark = Color(0xFF0F172A); // Slate 900
  static const Color textMedium = Color(0xFF334155); // Slate 700
  static const Color textLight = Color(0xFF64748B); // Slate 500
  static const Color borderLight = Color(0xFFE2E8F0); // Slate 200

  // Corner Radii
  static final BorderRadius radiusSmall = BorderRadius.circular(10.0);
  static final BorderRadius radiusMedium = BorderRadius.circular(16.0);
  static final BorderRadius radiusLarge = BorderRadius.circular(24.0);

  // Soft Shadows
  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: const Color(0xFF1E293B).withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  /// ThemeData for the entire app.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: primaryDark,
        surface: cardBackground,
      ),
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: null, // Default system font for best clarity
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: textDark,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primarySurface, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
