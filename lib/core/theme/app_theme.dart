import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: TextStyles.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        titleTextStyle: TextStyles.headline.copyWith(color: AppColors.white),
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreen,
      ),
    );
  }
}
