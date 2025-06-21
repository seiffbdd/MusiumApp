import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/components.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Components.h(
              componentHeight: 9, currentScreenHeight: screenHeight),
          width:
              Components.w(componentWidth: 55, currentScreenWidth: screenWidth),
          decoration: BoxDecoration(
            color: AppColors.cyan,
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        Container(
          height: Components.h(
              componentHeight: 9, currentScreenHeight: screenHeight),
          width:
              Components.w(componentWidth: 55, currentScreenWidth: screenWidth),
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ],
    );
  }
}
