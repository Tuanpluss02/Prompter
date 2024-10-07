import 'package:flutter/material.dart';

class AppResponsiveBuilder extends StatelessWidget {
  const AppResponsiveBuilder({
    required this.mobileBuilder,
    required this.tabletBuilder,
    super.key,
  });

  final Widget Function(
    BuildContext context,
    BoxConstraints constraint,
  ) mobileBuilder;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraint,
  ) tabletBuilder;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 450;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1250 &&
          MediaQuery.of(context).size.width >= 450;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1250;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1250) {
        return const SizedBox();
      } else if (constraints.maxWidth >= 450) {
        return tabletBuilder(context, constraints);
      } else {
        return mobileBuilder(context, constraints);
      }
    });
  }
}
