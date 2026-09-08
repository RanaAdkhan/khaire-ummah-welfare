import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF006039);
  static const Color primaryDark = Color(0xFF033A21);
  static const Color primaryLight = Color(0xFFF0FDF4);
  static const Color accent = Color(0xFFDFA22A);
  static const Color accentGold = Color(0xFFF59E0B);
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBg = Colors.white;
  static const Color textMain = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);
  static const Color redAccent = Color(0xFFDC2626);
  static const Color greenAccent = Color(0xFF16A34A);

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF006039), Color(0xFF033A21)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
  );
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.cardBg,
      ),
      textTheme: GoogleFonts.notoNastaliqUrduTextTheme().copyWith(
        displayLarge: GoogleFonts.notoNastaliqUrdu(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain),
        displayMedium: GoogleFonts.notoNastaliqUrdu(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textMain),
        titleLarge: GoogleFonts.notoNastaliqUrdu(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
        titleMedium: GoogleFonts.notoNastaliqUrdu(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textMain),
        bodyLarge: GoogleFonts.notoNastaliqUrdu(fontSize: 15, color: AppColors.textMain),
        bodyMedium: GoogleFonts.notoNastaliqUrdu(fontSize: 14, color: AppColors.textMuted),
        labelLarge: GoogleFonts.notoNastaliqUrdu(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: AppColors.cardBg,
        elevation: 2,
        shadowColor: AppColors.primary.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}
