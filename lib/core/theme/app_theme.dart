import 'package:flutter/material.dart';

import 'page_transitions.dart';

/// Design tokens for the app
class DesignTokens {
  const DesignTokens._();

  // Spacing
  static const double spacing0 = 0;
  static const double spacing1 = 4;
  static const double spacing2 = 8;
  static const double spacing3 = 12;
  static const double spacing4 = 16;
  static const double spacing5 = 20;
  static const double spacing6 = 24;
  static const double spacing8 = 32;
  static const double spacing10 = 40;
  static const double spacing12 = 48;
  static const double spacing16 = 64;
  static const double spacing20 = 80;

  // Border radius
  static const double radiusSmall = 12;
  static const double radiusMedium = 16;
  static const double radiusLarge = 20;
  static const double radiusXLarge = 28;

  // Elevation (for shadow)
  static const double elevationNone = 0;
  static const double elevationSubtle = 2;
  static const double elevationMedium = 8;
  static const double elevationHigh = 16;

  // Durations (ms)
  static const int durationFast = 120;
  static const int durationNormal = 200;
  static const int durationSlow = 300;
  static const int durationSlower = 400;
}

/// App colors
class AppColors {
  const AppColors._();

  // Dark theme colors
  static const Color darkBackground = Color(0xFF12141A);
  static const Color darkSurface = Color(0xFF121214);
  static const Color darkSurfaceVariant = Color(0xFF1C1C1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA0A0A5);
  static const Color darkTextTertiary = Color(0xFF5E5E61);

  // Light theme colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF3F4F6);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);

  // Accent colors
  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color primaryVariant = Color(0xFF818CF8); // Indigo 400
  static const Color secondary = Color(0xFFEC4899); // Pink 500

  // Semantic colors
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color success = Color(0xFF10B981); // Green 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
}

/// Neumorphic shadow data class
class NeumorphicShadow {
  final List<BoxShadow> raised;
  final List<BoxShadow> inset;
  final List<BoxShadow> buttonPressed;

  const NeumorphicShadow({
    required this.raised,
    required this.inset,
    required this.buttonPressed,
  });
}

/// Dark mode neumorphic shadows
const neumorphicDark = NeumorphicShadow(
  raised: [
    BoxShadow(color: Color(0x3D0A0B0E), offset: Offset(8, 8), blurRadius: 16),
    BoxShadow(color: Color(0xFF1A1D26), offset: Offset(-8, -8), blurRadius: 16),
  ],
  inset: [
    BoxShadow(color: Color(0x3D0A0B0E), offset: Offset(4, 4), blurRadius: 8, spreadRadius: 1),
    BoxShadow(color: Color(0xFF1A1D26), offset: Offset(-4, -4), blurRadius: 8, spreadRadius: 1),
  ],
  buttonPressed: [
    BoxShadow(color: Color(0x3D0A0B0E), offset: Offset(2, 2), blurRadius: 4),
    BoxShadow(color: Color(0xFF1A1D26), offset: Offset(-2, -2), blurRadius: 4),
  ],
);

/// Light mode neumorphic shadows
const neumorphicLight = NeumorphicShadow(
  raised: [
    BoxShadow(color: Color(0x1AE0E0E0), offset: Offset(6, 6), blurRadius: 12),
    BoxShadow(color: Color(0xFFFFFFFF), offset: Offset(-6, -6), blurRadius: 12),
  ],
  inset: [
    BoxShadow(color: Color(0x1AE0E0E0), offset: Offset(3, 3), blurRadius: 6, spreadRadius: 1),
    BoxShadow(color: Color(0xFFFFFFFF), offset: Offset(-3, -3), blurRadius: 6, spreadRadius: 1),
  ],
  buttonPressed: [
    BoxShadow(color: Color(0x1AE0E0E0), offset: Offset(1.5, 1.5), blurRadius: 3),
    BoxShadow(color: Color(0xFFFFFFFF), offset: Offset(-1.5, -1.5), blurRadius: 3),
  ],
);

/// Light theme data with dynamic accent color
ThemeData lightTheme({Color accentColor = AppColors.primary}) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: accentColor,
      secondary: AppColors.secondary,
      error: AppColors.error,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextPrimary,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: accentColor,
      unselectedItemColor: AppColors.lightTextSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: DesignTokens.elevationSubtle,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      height: 65,
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(color: AppColors.primary);
        }
        return TextStyle(color: AppColors.lightTextSecondary);
      }),
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: AppColors.primary);
        }
        return IconThemeData(color: AppColors.lightTextSecondary);
      }),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.lightSurface,
      elevation: DesignTokens.elevationSubtle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DesignTokens.radiusMedium),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
    textTheme: _buildTextTheme(AppColors.lightTextPrimary),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(),
        TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(),
      },
    ),
  );
}

/// Dark theme data with dynamic accent color
ThemeData darkTheme({Color accentColor = AppColors.primary}) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: accentColor,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: accentColor,
      unselectedItemColor: AppColors.darkTextSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: DesignTokens.elevationSubtle,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.darkSurface,
      elevation: DesignTokens.elevationSubtle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DesignTokens.radiusMedium),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
    textTheme: _buildTextTheme(AppColors.darkTextPrimary),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(),
        TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(),
      },
    ),
  );
}

/// Build text theme
TextTheme _buildTextTheme(Color primaryColor) {
  return TextTheme(
    // Display
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: primaryColor,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    ),

    // Headline
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),

    // Title
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),

    // Body
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),

    // Label
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
  );
}
