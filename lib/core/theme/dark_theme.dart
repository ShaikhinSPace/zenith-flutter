import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenith/core/theme/app_colors.dart';

ThemeData get darkTheme => ThemeData(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: AppColors.backgroundColor.darkColor,
  primaryColor: AppColors.primaryColor.darkColor,
  brightness: Brightness.dark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor.darkColor,
    selectedItemColor: AppColors.whiteColor.darkColor,
    unselectedItemColor: AppColors.greyColor.darkColor,
    unselectedLabelStyle: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    ),
    selectedLabelStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor.darkColor,
  ),
  datePickerTheme: DatePickerThemeData(
    surfaceTintColor: AppColors.primaryColor.darkColor,
    headerBackgroundColor: AppColors.darkGreyColor.darkColor.withValues(
      alpha: 0.7,
    ),
    headerForegroundColor: AppColors.whiteColor.darkColor,
    backgroundColor: AppColors.whiteColor.darkColor,
    dayOverlayColor: WidgetStatePropertyAll(AppColors.whiteColor.darkColor),
    todayBackgroundColor: WidgetStatePropertyAll(
      AppColors.darkGreyColor.darkColor.withValues(alpha: 0.7),
    ),
    todayForegroundColor: WidgetStatePropertyAll(
      AppColors.whiteColor.darkColor,
    ),
    dayForegroundColor: WidgetStatePropertyAll(AppColors.greyColor.darkColor),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.darkGreyColor.darkColor,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.darkGreyColor.darkColor,
      ),
    ),
    dividerColor: AppColors.darkGreyColor.darkColor,
    weekdayStyle: TextStyle(
      color: AppColors.darkGreyColor.darkColor.withValues(alpha: 0.5),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.darkGreyColor.darkColor),
    ),
    rangePickerBackgroundColor: AppColors.whiteColor.darkColor,
    rangePickerHeaderBackgroundColor: AppColors.accentColor.darkColor,
    rangePickerHeaderForegroundColor: AppColors.whiteColor.darkColor,
    rangePickerHeaderHeadlineStyle: TextStyle(
      color: AppColors.whiteColor.darkColor,
      fontSize: 16.sp,
    ),
    rangePickerHeaderHelpStyle: TextStyle(
      color: AppColors.whiteColor.darkColor,
    ),
    rangePickerSurfaceTintColor: AppColors.whiteColor.darkColor,
    rangeSelectionOverlayColor: WidgetStatePropertyAll(
      AppColors.whiteColor.darkColor,
    ),
    rangeSelectionBackgroundColor: AppColors.accentColor.darkColor.withValues(
      alpha: 0.2,
    ),
    rangePickerElevation: 0,
    rangePickerShadowColor: AppColors.whiteColor.darkColor,
    todayBorder: BorderSide(color: AppColors.whiteColor.darkColor),
  ),
  timePickerTheme: TimePickerThemeData(
    dayPeriodColor: AppColors.darkGreyColor.darkColor,
    dayPeriodTextStyle: TextStyle(color: AppColors.darkGreyColor.darkColor),
    dayPeriodBorderSide: BorderSide(
      color: AppColors.darkGreyColor.darkColor.withValues(alpha: 0.2),
    ),
    dialTextColor: AppColors.darkGreyColor.darkColor,
    dialBackgroundColor: AppColors.darkGreyColor.darkColor.withValues(
      alpha: 0.2,
    ),
    dayPeriodTextColor: AppColors.darkGreyColor.darkColor,
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.r),
    ),
    dialHandColor: AppColors.darkGreyColor.darkColor.withValues(alpha: 0.5),
    hourMinuteColor: AppColors.darkGreyColor.darkColor.withValues(alpha: 0.2),
    hourMinuteTextColor: AppColors.darkGreyColor.darkColor,
    entryModeIconColor: AppColors.darkGreyColor.darkColor,
    backgroundColor: AppColors.darkGreyColor.darkColor,
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.darkGreyColor.darkColor,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        AppColors.darkGreyColor.darkColor,
      ),
    ),
    helpTextStyle: TextStyle(color: AppColors.darkGreyColor.darkColor),
  ),
  colorScheme: ColorScheme.dark(
    surface: AppColors.darkGreyColor.darkColor,
    onSurface: AppColors.whiteColor.darkColor,
    surfaceTint: AppColors.darkGreyColor.darkColor,
    error: Colors.red,
    onError: Colors.red,
    onPrimary: AppColors.whiteColor.darkColor,
    onSecondary: AppColors.accentColor.darkColor,
    primary: AppColors.darkGreyColor.darkColor,
    secondary: AppColors.accentColor.darkColor,
    errorContainer: Colors.red,
    inversePrimary: Colors.green,
    inverseSurface: Colors.pink,
  ),
);
