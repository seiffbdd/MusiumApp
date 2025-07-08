import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musium/core/presentation/components.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.assetPath,
    required this.title,
    this.onTap,
  });
  final String assetPath;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return InkWell(
      onTap: onTap ?? () {},
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: Components.h(
            componentHeight: 55,
            currentScreenHeight: screenHeight,
          ),
          maxHeight: Components.h(
            componentHeight: 80.0,
            currentScreenHeight: screenHeight,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0XFF436369).withValues(alpha: 0.2),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(assetPath),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
