import 'package:flutter/material.dart';
import 'package:musium/config/theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.hineStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.isPassword = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hineStyle;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool isPassword;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  IconData _eye = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hineStyle ??
            Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.textWhite.withValues(alpha: 0.27)),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.textWhite.withValues(alpha: 0.27),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _eye == Icons.remove_red_eye
                        ? _eye = Icons.remove_red_eye_outlined
                        : _eye = Icons.remove_red_eye;
                  });
                },
                icon: Icon(
                  _eye,
                  color: AppColors.textWhite.withValues(alpha: 0.27),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: AppColors.textWhite.withValues(alpha: 0.27)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: AppColors.textWhite.withValues(alpha: 0.27)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: AppColors.textWhite.withValues(alpha: 0.27)),
        ),
      ),
      obscureText: widget.isPassword
          ? _eye == Icons.remove_red_eye
              ? true
              : false
          : false,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'This field can\'t be empty';
            }
            return null;
          },
    );
  }
}
