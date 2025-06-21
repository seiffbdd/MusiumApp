import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';

/// Defines the text styles used across the app for **mobile** screens.
/// Font sizes are optimized for smaller screen dimensions.
TextTheme get mobileTextTheme => TextTheme(
      displaySmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      headlineLarge: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: AppColors.cyan,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textMutedGrey,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textMutedGrey,
      ),
    );

/// Defines the text styles used across the app for **tablet** screens.
/// Font sizes are scaled up to better utilize larger screen real estate.
TextTheme get tabletTextTheme => TextTheme(
      displaySmall: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      headlineLarge: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: AppColors.cyan,
      ),
      headlineMedium: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      headlineSmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      titleLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      ),
      titleMedium: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.textMutedGrey,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textMutedGrey,
      ),
    );
