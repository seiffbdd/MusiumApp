import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      maxLines: 4,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'From the ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextSpan(
            text: 'latest',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.textcyanBright),
          ),
          TextSpan(
            text: ' to the ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextSpan(
            text: 'greatest',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.textcyanBright),
          ),
          TextSpan(
            text: ' hits, play your favorite tracks on ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextSpan(
            text: 'musium ',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.textcyanBright),
          ),
          TextSpan(
            text: 'now!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
