import 'package:flutter/material.dart';
import 'package:musium/core/constants/breakpoint.dart';

/// A reusable widget that switches between mobile and tablet layouts
/// based on the device's shortest side (width or height depending on orientation).
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
  });
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide <= tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide > tabletBreakpoint;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine layout based on the shortest side of the screen
        if (MediaQuery.sizeOf(context).shortestSide <= tabletBreakpoint) {
          return mobile;
        } else {
          return tablet;
        }
      },
    );
  }
}
