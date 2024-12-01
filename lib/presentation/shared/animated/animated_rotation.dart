import 'package:flutter/material.dart';

class CustomAnimatedRotation extends StatefulWidget {
  const CustomAnimatedRotation({
    super.key,
    required this.child,
    required this.controller,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final CustomAnimatedRotationController controller;
  final Curve curve;
  final Duration duration;

  @override
  State<CustomAnimatedRotation> createState() => _CustomAnimatedRotationState();
}

class _CustomAnimatedRotationState extends State<CustomAnimatedRotation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    widget.controller.attach(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _curvedAnimation,
      alignment: Alignment.center,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

class CustomAnimatedRotationController {
  late AnimationController _controller;

  void attach(AnimationController controller) {
    _controller = controller;
  }

  void start() {
    _controller.repeat();
  }

  void stop() {
    _controller.stop();
  }

  void dispose() {
    _controller.dispose();
  }
}
