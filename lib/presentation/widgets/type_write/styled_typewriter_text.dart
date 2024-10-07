import 'package:flutter/material.dart';

class StyledTypewriterText extends StatefulWidget {
  final List<StyledTextSegment> segments;
  final Duration duration;
  final bool repeat;
  final double lineHeight;

  const StyledTypewriterText({
    super.key,
    required this.segments,
    this.duration = const Duration(milliseconds: 100),
    this.repeat = false,
    this.lineHeight = 1.2,
  });

  @override
  State<StatefulWidget> createState() => _StyledTypewriterTextState();
}

class StyledTextSegment {
  final String text;
  final TextStyle style;

  StyledTextSegment(this.text, this.style);
}

class _StyledTypewriterTextState extends State<StyledTypewriterText> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<int>? _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  @override
  void didUpdateWidget(StyledTypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.segments != oldWidget.segments) {
      _initializeAnimation();
    }
  }

  void _initializeAnimation() {
    _controller?.dispose();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = StepTween(
      begin: 0,
      end: _calculateTotalLength(),
    ).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.repeat) {
        _controller!.repeat();
      } else if (status == AnimationStatus.completed) {
        // Remove this line, as we handle disposal in dispose method
        // _controller!.dispose();
      }
    });

    _controller!.forward();
  }

  int _calculateTotalLength() {
    return widget.segments.fold(
      0,
      (previousValue, segment) => previousValue + segment.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLength = _animation?.value ?? 0;
    List<TextSpan> textSpans = [];
    int lengthSoFar = 0;

    for (var segment in widget.segments) {
      final textStyle = segment.style.copyWith(
        height: widget.lineHeight,
      );
      if (lengthSoFar + segment.text.length <= currentLength) {
        textSpans.add(TextSpan(text: segment.text, style: textStyle));
      } else {
        textSpans.add(
          TextSpan(
            text: segment.text.substring(0, currentLength - lengthSoFar),
            style: textStyle,
          ),
        );
        break;
      }
      lengthSoFar += segment.text.length;
    }
    return RichText(
      text: TextSpan(
        children: textSpans,
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
