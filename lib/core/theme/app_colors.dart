import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const backgroundMain = Color(0xFF020205);
  static const backgroundDeep = Color(0xFF0D0917);
  static const backgroundSubtle = Color(0xFF150E1E);

  // Surfaces / Cards
  static const surfaceBase = Color(0xFF1E1823);
  static const surfaceElevated = Color(0xFF2D2232);
  static const surfaceMuted = Color(0xFF454046);

  // Accents / Interactive
  static const accentOrange = Color(0xFFFF6A3D);
  static const accentPink = Color(0xFFEA4B71);
  static const accentBlue = Color(0xFF3B82F6);

  // Hover States
  static const orangeHover = Color(0xFFFF835A);
  static const pinkHover = Color(0xFFF26B8A);
  static const blueHover = Color(0xFF639BFF);

  // Text & Card system
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFD1CEDA);
  static const cardBorder = surfaceMuted;

  // Recommended combinations (kept as lists)
  static const backgroundCombo1 = [backgroundMain, surfaceBase];
  static const backgroundCombo2 = [backgroundDeep, surfaceElevated];
}

class AppGradients {
  static const hero = LinearGradient(
    colors: [
      AppColors.backgroundDeep,
      AppColors.backgroundSubtle,
      AppColors.surfaceElevated,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const buttonCta = LinearGradient(
    colors: [
      AppColors.accentOrange,
      AppColors.accentPink,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const glowAccentRadial = RadialGradient(
    colors: [
      AppColors.accentPink,
      AppColors.accentOrange,
    ],
    center: Alignment.center,
    radius: 0.8,
  );
}

class AppHierarchy {
  static const layers = [
    AppColors.backgroundMain,
    AppColors.backgroundDeep,
    AppColors.backgroundSubtle,
    AppColors.surfaceBase,
    AppColors.surfaceElevated,
    AppColors.accentOrange,
    AppColors.accentPink,
    AppColors.accentBlue,
    AppColors.surfaceMuted,
  ];
}

class AppDecorations {
  static BoxDecoration hero() => const BoxDecoration(gradient: AppGradients.hero);
  static BoxDecoration button({double radius = 8}) => BoxDecoration(
        gradient: AppGradients.buttonCta,
        borderRadius: BorderRadius.circular(radius),
      );
  static BoxDecoration glow() => const BoxDecoration(gradient: AppGradients.glowAccentRadial);
}
