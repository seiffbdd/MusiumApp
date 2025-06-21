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
  });
  final String text;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(
          Components.h(
              componentHeight: 16.0,
              currentScreenHeight: MediaQuery.sizeOf(context).height),
        ),
        minimumSize: Size.fromHeight(Components.h(
            componentHeight: 59,
            currentScreenHeight: MediaQuery.sizeOf(context).height)),
        backgroundColor: AppColors.buttonBackgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
      child: Text(text,
          style: textStyle ??
              GoogleFonts.mulish(
                  textStyle: Theme.of(context).textTheme.titleLarge)),
    );
  }
}
