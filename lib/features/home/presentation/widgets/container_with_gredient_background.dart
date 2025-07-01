import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';

class ContainerWithGredientBackground extends StatelessWidget {
  const ContainerWithGredientBackground({
    super.key,
    required this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.buttonBackgroundColor.withValues(
                alpha: 0.5,
              ),
              AppColors.gradient.withValues(alpha: 0.5),
              AppColors.backgroundDark.withValues(alpha: 0.5)
            ],
          ),
        ),
        child: child);
  }
}
