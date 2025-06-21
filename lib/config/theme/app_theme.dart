import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/config/theme/text_theme.dart';
import 'package:musium/core/presentation/responsive_layout.dart';

/// Returns ThemeData dynamically based on screen size (mobile/tablet).
ThemeData buildAppTheme(BuildContext context) {
  final textTheme =
      ResponsiveLayout.isMobile(context) ? mobileTextTheme : tabletTextTheme;

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: textTheme,
    fontFamily: 'GothicA1',
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.mulish(
            textStyle: TextStyle(
              color: AppColors.accentTeal,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
