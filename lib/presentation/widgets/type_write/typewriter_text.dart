import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final bool repeat;

  const TypewriterText({
    super.key,
    required this.text,
    this.style = const TextStyle(),
    this.duration = const Duration(milliseconds: 100),
    this.repeat = false,
  });

  @override
  State<StatefulWidget> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.repeat) {
        _controller.repeat();
      } else if (status == AnimationStatus.completed) {
        _controller.dispose();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.substring(0, _animation.value),
      style: widget.style,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
