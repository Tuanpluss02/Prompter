import 'dart:math' as math show sin, pi;
import 'dart:math';

import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    this.size = 30.0,
    this.duration = const Duration(milliseconds: 1400),
    this.controller,
  });

  final double size;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  List colors = [Colors.red, Colors.green, Colors.yellow, Colors.blue];
  Random random = Random();

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 2, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            return ScaleTransition(
              scale: DelayTween(begin: 0.0, end: 1.0, delay: i * .2).animate(_controller!),
              child: SizedBox.fromSize(size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => DecoratedBox(decoration: BoxDecoration(color: colors[index], shape: BoxShape.circle));
}

class DelayTween extends Tween<double> {
  DelayTween({super.begin, super.end, this.delay});

  final double? delay;

  @override
  double lerp(double t) => super.lerp((math.sin((t - delay!) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
