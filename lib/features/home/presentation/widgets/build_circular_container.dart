import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musium/config/theme/app_colors.dart';

class BuildCircularContainer extends StatelessWidget {
  const BuildCircularContainer({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: 56.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.lightCyan, AppColors.cyan],
        ),
      ),
      child: Icon(
        icon,
        color: AppColors.backgroundDark,
        size: 24.0.h,
      ),
    );
  }
}
