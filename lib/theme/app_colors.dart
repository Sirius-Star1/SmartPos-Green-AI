import 'package:flutter/material.dart';

/// Palet warna SmartPOS Green AI, mengikuti nuansa hijau pada mockup.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1E7A46);
  static const Color primaryDark = Color(0xFF14532D);
  static const Color primaryLight = Color(0xFF43A047);

  static const Color background = Color(0xFFF2F8F4);
  static const Color cardBackground = Colors.white;
  static const Color softGreenBg = Color(0xFFE7F5EC);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE2E8F0);

  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color infoBlue = Color(0xFF3B82F6);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color orange = Color(0xFFF97316);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
