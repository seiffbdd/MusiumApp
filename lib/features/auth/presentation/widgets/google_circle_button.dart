import 'package:flutter/material.dart';
import 'package:musium/config/assets/app_icons.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/components.dart';

class GoogleCircleButton extends StatelessWidget {
  const GoogleCircleButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: Components.h(
            componentHeight: 50,
            currentScreenHeight: MediaQuery.sizeOf(context).height),
        height: Components.h(
            componentHeight: 50,
            currentScreenHeight: MediaQuery.sizeOf(context).height),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.fillColor,
          border: Border.all(
            color: AppColors.textWhite.withValues(alpha: 0.27),
          ),
        ),
        child: Image.asset(AppIcons.googlePng),
      ),
    );
  }
}
