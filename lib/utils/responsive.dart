import 'package:flutter/material.dart';

/// Simple breakpoint helpers used across LearnHub so every screen adapts
/// consistently between phones, tablets and desktop/web widths.
class Responsive {
  Responsive._();

  static const double mobileMax = 599;
  static const double tabletMax = 1023;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w > mobileMax && w <= tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > tabletMax;

  /// Number of grid columns to use for card layouts (program lists,
  /// achievements, etc.) at the current screen width.
  static int columns(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 48;
    if (isTablet(context)) return 32;
    return 16;
  }
}

/// Centers content and caps its width on large screens so text and cards
/// don't stretch edge-to-edge on tablets, desktop or web.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 1100,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: hPad),
          child: child,
        ),
      ),
    );
  }
}