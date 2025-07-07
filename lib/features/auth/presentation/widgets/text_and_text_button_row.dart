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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            textAlign: TextAlign.right,
            text,
            style: GoogleFonts.mulish(
                textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.textWhite, fontWeight: FontWeight.normal)),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textButton,
              style: GoogleFonts.mulish(
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.textCyanDark,
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
