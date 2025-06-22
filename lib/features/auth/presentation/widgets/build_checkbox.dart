import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';

class BuildCheckbox extends StatefulWidget {
  const BuildCheckbox({
    super.key,
  });

  @override
  State<BuildCheckbox> createState() => _BuildCheckboxState();
}

class _BuildCheckboxState extends State<BuildCheckbox> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _checked,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.cyan,
      checkColor: AppColors.offWhite,
      overlayColor: WidgetStatePropertyAll(AppColors.cyan),
      onChanged: (value) {
        setState(() {
          _checked = value!;
        });
      },
      title: Text(
        'Remember me',
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: AppColors.textWhite),
      ),
    );
  }
}
