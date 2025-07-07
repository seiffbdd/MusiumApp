import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musium/config/theme/app_colors.dart';

class CustomTab extends StatefulWidget {
  const CustomTab(
      {super.key,
      required this.text,
      required this.selectedIndex,
      required this.index});
  final String text;
  final int index;
  final ValueNotifier<int> selectedIndex;

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 32.h,
      child: ValueListenableBuilder(
          valueListenable: widget.selectedIndex,
          builder: (context, currentIndex, _) {
            isSelected = currentIndex == widget.index;
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [const Color(0XFF1797A8), AppColors.cyan],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(23.sp),
                    border: isSelected
                        ? null
                        : BoxBorder.all(color: AppColors.textWhite)),
                child: Text(
                  widget.text,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.textWhite),
                ));
          }),
    );
  }
}
