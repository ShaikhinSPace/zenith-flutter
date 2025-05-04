import 'package:flutter/material.dart';
import 'package:zenith/common/extensions/theme_extension.dart';

class AppColors {
  AppColors._();

  // Success colors - calming green tones
  static const ColorModel successBackgroundColor = ColorModel(
    lightColor: Color(0xFFE0F2F1), // Soft mint background
    darkColor: Color(0xFF26A69A), // Teal for dark mode
  );

  // Warning colors - gentle amber tones
  static const ColorModel warningBackgroundColor = ColorModel(
    lightColor: Color(0xFFFFF8E1), // Soft amber background
    darkColor: Color(0xFFFFA000), // Amber for dark mode
  );

  // Info colors - calm blue tones
  static const ColorModel infoBackgroundColor = ColorModel(
    lightColor: Color(0xFFE3F2FD), // Soft blue background
    darkColor: Color(0xFF42A5F5), // Blue for dark mode
  );

  // Disabled button states
  static const ColorModel buttonDisableDarkColor = ColorModel(
    lightColor: Color(0xFF455A64), // Blue-gray for light mode
    darkColor: Color(0xFF263238), // Darker blue-gray for dark mode
  );

  static const ColorModel buttonDisableLightColor = ColorModel(
    lightColor: Color(0xFFECEFF1), // Light blue-gray for light mode
    darkColor: Color(0xFF546E7A), // Medium blue-gray for dark mode
  );

  // Background colors - using focus-friendly tones
  static const ColorModel backgroundColor = ColorModel(
    lightColor: Color(0xFFF5F7FA), // Crisp, clean light background
    darkColor: Color(0xFF1A2027), // Deep blue-black for dark mode
  );

  // Primary color - calming blue tone
  static const ColorModel primaryColor = ColorModel(
    lightColor: Color(0xFF3F51B5), // Indigo
    darkColor: Color(0xFF303F9F), // Darker indigo for dark mode
  );

  // Secondary color - complementary to primary
  static const ColorModel secondaryColor = ColorModel(
    lightColor: Color(0xFF5C6BC0), // Lighter indigo
    darkColor: Color(0xFF3949AB), // Medium indigo for dark mode
  );

  // Accent color - energizing but not distracting
  static const ColorModel accentColor = ColorModel(
    lightColor: Color(0xFF4DB6AC), // Teal
    darkColor: Color(0xFF009688), // Darker teal for dark mode
  );

  // Text colors - high readability
  static const ColorModel textColor = ColorModel(
    lightColor: Color(0xFF37474F), // Dark blue-gray for light mode
    darkColor: Color(0xFFECEFF1), // Light blue-gray for dark mode
  );

  // Grey tones for subtle elements
  static const ColorModel greyColor = ColorModel(
    lightColor: Color(0xFFB0BEC5), // Light blue-gray
    darkColor: Color(0xFF78909C), // Medium blue-gray for dark mode
  );

  // White-like colors
  static const ColorModel whiteColor = ColorModel(
    lightColor: Color(0xFFFFFFFF), // Pure white
    darkColor: Color(0xFFE1E2E1), // Off-white for dark mode
  );

  // Dark grey tones
  static const ColorModel darkGreyColor = ColorModel(
    lightColor: Color(0xFF455A64), // Medium blue-gray
    darkColor: Color(0xFF263238), // Deep blue-gray for dark mode
  );

  // Focus highlight color
  static const ColorModel focusColor = ColorModel(
    lightColor: Color(0xFF7986CB), // Soft indigo
    darkColor: Color(0xFF5C6BC0), // Medium indigo for dark mode
  );

  // Timer color - for study timers and pomodoro features
  static const ColorModel timerColor = ColorModel(
    lightColor: Color(0xFFFF7043), // Warm orange - energizing
    darkColor: Color(0xFFE64A19), // Darker orange for dark mode
  );

  // For dividers and subtle separators
  static const ColorModel dividerColor = ColorModel(
    lightColor: Color(0xFFCFD8DC), // Very light blue-gray
    darkColor: Color(0xFF455A64), // Medium blue-gray for dark mode
  );

  // For progress indicators
  static const ColorModel progressColor = ColorModel(
    lightColor: Color(0xFF8BC34A), // Light green
    darkColor: Color(0xFF689F38), // Darker green for dark mode
  );
}

class ColorModel {
  final Color lightColor;
  final Color darkColor;

  const ColorModel({required this.lightColor, required this.darkColor});
}

Color getColor({
  required BuildContext context,
  required ColorModel colorClass,
}) {
  return context.isDark ? colorClass.darkColor : colorClass.lightColor;
}
