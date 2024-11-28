import 'package:flutter/material.dart';

class AnimatedCustomRotation extends StatefulWidget {
  const AnimatedCustomRotation({
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
  State<AnimatedCustomRotation> createState() => _AnimatedCustomRotationState();
}

class _AnimatedCustomRotationState extends State<AnimatedCustomRotation> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(covariant AnimatedCustomRotation oldWidget) {
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
