import 'package:flutter/material.dart';

class AppTheme {
  // Cyberpunk inspired colors
  static const Color primaryCyan = Color(0xFF00F5FF);
  static const Color primaryPurple = Color(0xFF9D00FF);
  static const Color accentPink = Color(0xFFFF0080);
  static const Color accentGreen = Color(0xFF00FF41);
  static const Color backgroundDark = Color(0xFF0A0A0F);
  static const Color surfaceDark = Color(0xFF12121A);
  static const Color cardDark = Color(0xFF1A1A25);
  static const Color textPrimary = Color(0xFFE0E0E0);
  static const Color textSecondary = Color(0xFF808090);
  static const Color borderColor = Color(0xFF2A2A35);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primaryCyan,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        secondary: primaryPurple,
        tertiary: accentPink,
        surface: surfaceDark,
        error: accentPink,
        onPrimary: backgroundDark,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onError: textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'monospace',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryCyan,
          letterSpacing: 2,
        ),
        iconTheme: IconThemeData(color: primaryCyan),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: borderColor, width: 1),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryCyan,
        foregroundColor: backgroundDark,
        elevation: 8,
        shape: CircleBorder(),
      ),
      iconTheme: const IconThemeData(color: primaryCyan),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'monospace',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 1.5,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'monospace',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 1.2,
        ),
        titleLarge: TextStyle(
          fontFamily: 'monospace',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: 'monospace',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'monospace',
          fontSize: 16,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 1,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryCyan,
          foregroundColor: backgroundDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryCyan,
          side: const BorderSide(color: primaryCyan, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardDark,
        contentTextStyle: const TextStyle(
          fontFamily: 'monospace',
          color: textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: primaryCyan, width: 1),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor, width: 1),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryCyan,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          color: textPrimary,
        ),
      ),
      dividerTheme: const DividerThemeData(color: borderColor, thickness: 1),
    );
  }
}

// Custom widget decorations
class AppDecorations {
  static BoxDecoration get glowingBorder => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppTheme.primaryCyan.withOpacity(0.5), width: 1),
    boxShadow: [
      BoxShadow(
        color: AppTheme.primaryCyan.withOpacity(0.2),
        blurRadius: 8,
        spreadRadius: 0,
      ),
    ],
  );

  static BoxDecoration get cardGradient => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppTheme.cardDark, AppTheme.cardDark.withOpacity(0.8)],
    ),
    border: Border.all(color: AppTheme.borderColor, width: 1),
  );

  static BoxDecoration get scannerOverlay => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppTheme.primaryCyan, width: 3),
    boxShadow: [
      BoxShadow(
        color: AppTheme.primaryCyan.withOpacity(0.3),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
  );
}
