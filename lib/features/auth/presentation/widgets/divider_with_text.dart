import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({
    super.key,
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.white54, // or any color you want
            thickness: 1.0,
            endIndent: 10.0, // space between divider and text
          ),
        ),
        Text(text ?? 'or continue with',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.textWhite)),
        const Expanded(
          child: Divider(
            color: Colors.white54,
            thickness: 1.0,
            indent: 10.0, // space between text and divider
          ),
        ),
      ],
    );
  }
}
