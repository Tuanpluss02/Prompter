import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScaleButton extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final Duration duration;
  const ScaleButton({super.key, required this.child, required this.onTap, this.duration = const Duration(milliseconds: 100)});

  @override
  State<ScaleButton> createState() {
    return _ScaleButtonState();
  }
}

class _ScaleButtonState extends State<ScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  OverlayEntry? overlayEntry;



  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse().then(
          (value) {
            widget.onTap.call();
            removeHighlightOverlay();
          },
        );
      }
    });
  }

  removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  createHighlightOverlay({
    required BuildContext context,
    Widget? child,
  }) {
    removeHighlightOverlay();
    OverlayState overlayState = Overlay.of(context);
    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return AnimatedPositioned(
          width: Get.width,
          height: Get.height,
          duration: Duration.zero,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
            ),
            onTap: () {},
          ),
        );
      },
    );

    overlayState.insert(overlayEntry!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward();
    createHighlightOverlay(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          color: Colors.transparent,
          child: IgnorePointer(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
