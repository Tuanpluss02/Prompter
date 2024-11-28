import 'package:flutter/material.dart';

class CustomAnimatedRotation extends StatefulWidget {
  const CustomAnimatedRotation({
    super.key,
    required this.child,
    this.isRotating = true,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final bool isRotating;
  final Curve curve;
  final Duration duration;

  @override
  State<CustomAnimatedRotation> createState() => _CustomAnimatedRotationState();
}

class _CustomAnimatedRotationState extends State<CustomAnimatedRotation> with SingleTickerProviderStateMixin {
  late AnimationController refreshAnimation;
  late Animation<double> curvedAnimation;

  @override
  void initState() {
    super.initState();
    refreshAnimation = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    curvedAnimation = CurvedAnimation(
      parent: refreshAnimation,
      curve: widget.curve,
    );

    if (widget.isRotating) {
      refreshAnimation.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedRotation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.curve != oldWidget.curve) {
      curvedAnimation = CurvedAnimation(
        parent: refreshAnimation,
        curve: widget.curve,
      );
    }

    if (widget.isRotating != oldWidget.isRotating) {
      if (widget.isRotating) {
        refreshAnimation.repeat();
      } else {
        refreshAnimation.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: curvedAnimation,
      alignment: Alignment.center,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    refreshAnimation.dispose();
    super.dispose();
  }
}
