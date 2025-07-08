import 'package:flutter/material.dart';

import 'package:musium/config/assets/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(AppImages.musiumLogoPng),
      ),
    );
  }
}
