import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/constants/numbers.dart';

abstract class Components {
  /// Returns a height value proportionally scaled to the current screen height.
  ///
  /// [componentHeight] is the height of the component in the design (e.g., Figma).
  /// [currentScreenHeight] is the actual screen height of the device.
  static double h({
    required double componentHeight,
    required double currentScreenHeight,
  }) {
    final double heightRatio = componentHeight / designScreenHeight;
    return currentScreenHeight * heightRatio;
  }

  /// do the same as the first method but in width
  static double w({
    required double componentWidth,
    required double currentScreenWidth,
  }) {
    final double widthRatio = componentWidth / designScreenWidth;
    return currentScreenWidth * widthRatio;
  }

  static void showDefaultSnackBar({
    required BuildContext context,
    String? text,
    Color textColor = AppColors.textWhite,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? AppColors.fillColor,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        content: Text(
          '$text',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: textColor),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
