import 'package:flutter/material.dart';

// 색상 정의
class AppColors {
  static const lightPrimaryColor = Colors.green;
  static const lightBackgroundColor = Color(0xFFF5F5F5);
  static const lightTextColor = Color(0xFF3C3C3C);
  static const lightButtonTextColor = Colors.white;

  static const darkPrimaryColor = Colors.green;
  static const darkBackgroundColor = Color(0xFF212121);
  static const darkTextColor = Colors.white;
  static const darkButtonTextColor = Colors.black;
}

// 텍스트 스타일 정의
class AppTextStyles {
  static TextStyle titleStyle(bool isDarkMode) => TextStyle(
    fontFamily: 'SUIT-ExtraBold',
    fontSize: 30.0,
    color: isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor,
  );

  static TextStyle buttonTextStyle(bool isDarkMode) => TextStyle(
    fontFamily: 'SUIT-Light',
    fontSize: 16.0,
    color: isDarkMode ? AppColors.darkButtonTextColor : AppColors.lightButtonTextColor,
  );
}

// 버튼 스타일 정의
class AppButtonStyles {
  static ButtonStyle defaultButtonStyle(bool isDarkMode) =>
      TextButton.styleFrom(
        // backgroundColor: isDarkMode
        //     ? AppColors.darkPrimaryColor
        //     : AppColors.lightPrimaryColor,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
      );
}

// 테마 정의
ThemeData appTheme(bool isDarkMode) {
  return ThemeData(
    primaryColor: isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor,
    scaffoldBackgroundColor: isDarkMode
        ? AppColors.darkBackgroundColor
        : AppColors.lightBackgroundColor,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.titleStyle(isDarkMode), // headline1 → displayLarge
      labelLarge: AppTextStyles.buttonTextStyle(isDarkMode), // button → labelLarge
    ),
    textButtonTheme: TextButtonThemeData(
      style: AppButtonStyles.defaultButtonStyle(isDarkMode),
    ),
  );
}