import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musium/config/theme/app_colors.dart';

class TextAndTextButtonRow extends StatelessWidget {
  const TextAndTextButtonRow({
    super.key,
    required this.text,
    required this.textButton,
    this.onPressed,
  });
  final String text;
  final String textButton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: GoogleFonts.mulish(
              textStyle: Theme.of(context).textTheme.titleLarge),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              textButton,
              style: GoogleFonts.mulish(
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.textCyanDark)),
            ))
      ],
    );
  }
}
