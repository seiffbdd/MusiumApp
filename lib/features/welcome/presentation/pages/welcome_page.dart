import 'package:flutter/material.dart';
import 'package:musium/config/assets/app_images.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/constants/numbers.dart';
import 'package:musium/core/presentation/components.dart';
import 'package:musium/core/presentation/responsive_layout.dart';
import 'package:musium/core/presentation/widgets/default_rounded_button.dart';
import 'package:musium/features/welcome/presentation/widgets/custom_divider.dart';
import 'package:musium/features/welcome/presentation/widgets/custom_text_span.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: Components.h(
                componentHeight: designScreenHeight - 570,
                currentScreenHeight: screenHeight),
            top: Components.h(
                componentHeight: 156, currentScreenHeight: screenHeight),
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.imgGirlPng,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: Components.h(
                componentHeight: 32, currentScreenHeight: screenHeight),
            left: Components.w(
                componentWidth: 25, currentScreenWidth: screenWidth),
            child: SizedBox(
              height: Components.h(
                  componentHeight: 146, currentScreenHeight: screenHeight),
              width: Components.h(
                  componentHeight: 146, currentScreenHeight: screenHeight),
              child: Image.asset(
                AppImages.innerShadowPng,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: Components.h(
                componentHeight: 78, currentScreenHeight: screenHeight),
            left: Components.w(
                componentWidth: 300, currentScreenWidth: screenWidth),
            child: SizedBox(
              height: Components.h(
                  componentHeight: 78, currentScreenHeight: screenHeight),
              width: Components.h(
                  componentHeight: 78, currentScreenHeight: screenHeight),
              child: Image.asset(
                AppImages.innerShadowPng,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: Components.h(
                componentHeight: 226, currentScreenHeight: screenHeight),
            left: Components.w(
                componentWidth: 300, currentScreenWidth: screenWidth),
            child: SizedBox(
              height: Components.h(
                  componentHeight: 103, currentScreenHeight: screenHeight),
              width: Components.h(
                  componentHeight: 103, currentScreenHeight: screenHeight),
              child: Image.asset(
                AppImages.innerShadowPng,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Components.w(
                      componentWidth: 24, currentScreenWidth: screenWidth),
                  vertical: Components.h(
                      componentHeight: 42.0,
                      currentScreenHeight: screenHeight)),
              height: !ResponsiveLayout.isMobileLandscape(context)
                  ? Components.h(
                      componentHeight: 400, currentScreenHeight: screenHeight)
                  : screenHeight * 0.5,
              width: screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(54.0),
                  color: AppColors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: CustomTextSpan()),
                  Expanded(
                    child: CustomDivider(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                  ),
                  DefaultRoundedButton(
                    text: 'Get Started',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColors.accentTeal,
    );
  }
}
