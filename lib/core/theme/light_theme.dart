import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/core/theme/app_colors.dart';

ThemeData get lightTheme => ThemeData(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: AppColors.whiteColor.lightColor,
  primaryColor: AppColors.primaryColor.lightColor,
  brightness: Brightness.light,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteColor.lightColor,
    selectedItemColor: AppColors.primaryColor.lightColor,
    unselectedItemColor: AppColors.greyColor.lightColor,
    unselectedLabelStyle: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    ),
    selectedLabelStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.whiteColor.lightColor,
  ),
  datePickerTheme: DatePickerThemeData(
    surfaceTintColor: AppColors.primaryColor.lightColor,
    headerBackgroundColor: AppColors.backgroundColor.lightColor.withValues(
      alpha: 0.7,
    ),
    headerForegroundColor: AppColors.whiteColor.lightColor,
    backgroundColor: AppColors.whiteColor.lightColor,
    dayOverlayColor: WidgetStatePropertyAll(AppColors.primaryColor.lightColor),
    todayBackgroundColor: WidgetStatePropertyAll(
      AppColors.backgroundColor.lightColor.withValues(alpha: 0.7),
    ),
    todayForegroundColor: WidgetStatePropertyAll(
      AppColors.whiteColor.lightColor,
    ),
    dayForegroundColor: WidgetStatePropertyAll(AppColors.greyColor.lightColor),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.darkGreyColor.lightColor,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.darkGreyColor.lightColor,
      ),
    ),
    dividerColor: AppColors.darkGreyColor.lightColor,
    weekdayStyle: TextStyle(
      color: AppColors.darkGreyColor.lightColor.withValues(alpha: 0.5),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.greyColor.lightColor),
    ),
    rangePickerBackgroundColor: AppColors.whiteColor.lightColor,
    rangePickerHeaderBackgroundColor: AppColors.primaryColor.lightColor,
    rangePickerHeaderForegroundColor: AppColors.whiteColor.lightColor,
    rangePickerHeaderHeadlineStyle: TextStyle(
      color: AppColors.whiteColor.lightColor,
      fontSize: 16.sp,
    ),
    rangePickerHeaderHelpStyle: TextStyle(
      color: AppColors.whiteColor.lightColor,
    ),
    rangePickerSurfaceTintColor: AppColors.whiteColor.lightColor,
    rangeSelectionOverlayColor: WidgetStatePropertyAll(
      AppColors.whiteColor.lightColor,
    ),
    rangeSelectionBackgroundColor: AppColors.primaryColor.lightColor.withValues(
      alpha: 0.2,
    ),
    rangePickerElevation: 0,
    rangePickerShadowColor: AppColors.greyColor.lightColor,
    todayBorder: BorderSide(color: AppColors.backgroundColor.lightColor),
  ),
  timePickerTheme: TimePickerThemeData(
    dayPeriodColor: AppColors.backgroundColor.lightColor,
    dayPeriodTextStyle: TextStyle(color: AppColors.backgroundColor.lightColor),
    dayPeriodBorderSide: BorderSide(
      color: AppColors.backgroundColor.lightColor.withValues(alpha: 0.2),
    ),
    dialTextColor: AppColors.backgroundColor.lightColor,
    dialBackgroundColor: AppColors.whiteColor.lightColor.withValues(alpha: 0.1),
    dialHandColor: AppColors.primaryColor.lightColor.withValues(alpha: 0.5),
    hourMinuteColor: AppColors.whiteColor.lightColor.withValues(alpha: 0.1),
    hourMinuteTextColor: AppColors.backgroundColor.lightColor,
    entryModeIconColor: AppColors.backgroundColor.lightColor,
    backgroundColor: AppColors.whiteColor.lightColor,
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.backgroundColor.lightColor,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.backgroundColor.lightColor,
      ),
    ),
    helpTextStyle: TextStyle(color: AppColors.backgroundColor.lightColor),
  ),
  colorScheme: ColorScheme.light(
    surface: AppColors.whiteColor.lightColor,
    onSurface: AppColors.textColor.lightColor,
    surfaceTint: AppColors.whiteColor.lightColor,
    error: AppColors.accentColor.lightColor,
    onError: AppColors.whiteColor.lightColor,
    onPrimary: AppColors.whiteColor.lightColor,
    onSecondary: AppColors.accentColor.lightColor,
    primary: AppColors.primaryColor.lightColor,
    secondary: AppColors.secondaryColor.lightColor,
    errorContainer: AppColors.accentColor.lightColor,
    inversePrimary: AppColors.greyColor.lightColor,
    inverseSurface: AppColors.backgroundColor.lightColor,
  ),
);
