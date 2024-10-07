import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A widget that animates the transition between two children using a
/// [SharedAxisTransition] with a vertical axis.
///
/// This widget is particularly useful for creating smooth transitions between
/// different content sections, such as switching between login and signup forms.
class AnimatedVerticalFadeSwitcher extends StatelessWidget {
  /// The widget to display if [isSecondChild] is `false`.
  final Widget firstChild;

  /// The widget to display if [isSecondChild] is `true`.
  final Widget secondChild;

  /// Whether to display the [secondChild] widget.
  final bool isSecondChild;

  /// The duration of the animation.
  final Duration duration;

  /// The alignment of the children within the transition.
  final AlignmentGeometry alignment;

  /// Creates an [AnimatedVerticalFadeSwitcher].
  const AnimatedVerticalFadeSwitcher({
    super.key,
    required this.firstChild,
    required this.isSecondChild,
    required this.secondChild,
    this.duration = const Duration(milliseconds: 500),
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: duration,
      reverse: !isSecondChild,
      transitionBuilder: (
        Widget child,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          child: child,
        );
      },
      child: isSecondChild ? secondChild : firstChild,
    );
  }
}
