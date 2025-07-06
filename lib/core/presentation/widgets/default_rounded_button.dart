import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/components.dart';

class DefaultRoundedButton extends StatelessWidget {
  const DefaultRoundedButton({
    super.key,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.icon,
    this.backgroundColor,
  });
  final String text;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  final Icon? icon;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        text,
        style: textStyle ??
            GoogleFonts.mulish(
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
      ),
      iconAlignment: IconAlignment.start,
      icon: icon,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        iconSize: Components.h(
            componentHeight: 32.0,
            currentScreenHeight: MediaQuery.sizeOf(context).height),
        padding: EdgeInsets.all(
          Components.h(
              componentHeight: 16.0,
              currentScreenHeight: MediaQuery.sizeOf(context).height),
        ),
        minimumSize: Size.fromHeight(Components.h(
            componentHeight: 59,
            currentScreenHeight: MediaQuery.sizeOf(context).height)),
        backgroundColor: backgroundColor ?? AppColors.buttonBackgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
    );
  }
}
