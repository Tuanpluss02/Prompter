import 'dart:async';

import 'package:flutter/material.dart';

/// A custom painter for drawing the arrow of the tooltip.
class TooltipArrowPainter extends CustomPainter {
  /// The size of the arrow.
  final Size size;

  /// The color of the arrow.
  final Color color;

  /// Whether the arrow is inverted (pointing up).
  final bool isInverted;

  /// Creates a new `TooltipArrowPainter`.
  TooltipArrowPainter({
    required this.size,
    required this.color,
    required this.isInverted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isInverted) {
      path.moveTo(0.0, size.height);
      path.lineTo(size.width / 2, 0.0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0.0, 0.0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0.0);
    }

    path.close();

    canvas.drawShadow(path, Colors.black, 4.0, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A widget that displays an arrow for the tooltip.
class TooltipArrow extends StatelessWidget {
  /// The size of the arrow.
  final Size size;

  /// The color of the arrow.
  final Color color;

  /// Whether the arrow is inverted (pointing up).
  final bool isInverted;

  /// Creates a new `TooltipArrow`.
  const TooltipArrow({
    super.key,
    this.size = const Size(16.0, 16.0),
    this.color = Colors.white,
    this.isInverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-size.width / 2, 0.0),
      child: CustomPaint(
        size: size,
        painter: TooltipArrowPainter(
          size: size,
          color: color,
          isInverted: isInverted,
        ),
      ),
    );
  }
}

/// An enum that defines the position of the tooltip.
enum TooltipPosition { top, bottom }

class AnimatedTooltipController extends ChangeNotifier {
  void showTooltip() => notifyListeners();
  void hideTooltip() => notifyListeners();
}

/// An animated tooltip widget that displays with a customizable position, delay, and theme.
///
/// The `AnimatedTooltip` widget is used to display a tooltip with an arrow
/// pointing to a target widget. It can be positioned above or below the
/// target widget, and can be customized with a delay, theme, and content.
///
/// The tooltip is displayed using an [OverlayPortal], which allows it to be
/// displayed outside the bounds of its parent widget. The tooltip is
/// animated using a [ScaleTransition] to create a smooth appearance and
/// disappearance.
///
/// Example usage:
/// ```dart
/// AnimatedTooltip(
///   content: Text('This is a tooltip'),
///   targetGlobalKey: globalKey,
///   position: TooltipPosition.bottom,
///   delay: Duration(milliseconds: 500),
///   child: Icon(Icons.info),
/// )
/// ```
///
/// This will display a tooltip with the text "This is a tooltip" when the
/// icon is tapped. The tooltip will be positioned below the icon, and will
/// be displayed after a delay of 500 milliseconds.
class AnimatedTooltip extends StatefulWidget {
  /// The content of the tooltip.
  final Widget content;

  /// The global key of the target widget.
  final GlobalKey? targetGlobalKey;

  /// The delay before the tooltip is displayed.
  final Duration? delay;

  /// The theme of the tooltip.
  final ThemeData? theme;

  /// The child widget that triggers the tooltip.
  final Widget? child;

  /// The position of the tooltip relative to the target widget.
  final TooltipPosition? position;

  final AnimatedTooltipController? controller;

  /// Creates a new `AnimatedTooltip`.
  const AnimatedTooltip({
    super.key,
    required this.content,
    this.targetGlobalKey,
    this.theme,
    this.delay,
    this.child,
    this.position,
    this.controller,
  }) : assert(child != null || targetGlobalKey != null);

  @override
  State<StatefulWidget> createState() => AnimatedTooltipState();
}

/// The state for the `AnimatedTooltip` widget.
class AnimatedTooltipState extends State<AnimatedTooltip> with SingleTickerProviderStateMixin {
  late double? _tooltipTop;
  late double? _tooltipBottom;
  late Alignment _tooltipAlignment;
  late Alignment _transitionAlignment;
  late Alignment _arrowAlignment;
  bool _isInverted = false;
  Timer? _delayTimer;

  final _arrowSize = const Size(16.0, 16.0);
  final _tooltipMinimumHeight = 140.0;

  final _overlayController = OverlayPortalController();
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutBack,
  );

  void _toggle() {
    _delayTimer?.cancel();
    _animationController.stop();
    if (_overlayController.isShowing) {
      _animationController.reverse().then((_) {
        _overlayController.hide();
      });
    } else {
      _updatePosition();
      _overlayController.show();
      _animationController.forward();
    }
  }

  void _updatePosition() {
    final Size contextSize = MediaQuery.of(context).size;
    final BuildContext? targetContext = widget.targetGlobalKey != null ? widget.targetGlobalKey!.currentContext : context;
    final targetRenderBox = targetContext?.findRenderObject() as RenderBox;
    final targetOffset = targetRenderBox.localToGlobal(Offset.zero);
    final targetSize = targetRenderBox.size;

    if (widget.position != null) {
      switch (widget.position) {
        case TooltipPosition.top:
          _tooltipTop = targetOffset.dy - _tooltipMinimumHeight / 2;
          _tooltipBottom = null;
          break;
        case TooltipPosition.bottom:
          _tooltipTop = null;
          _tooltipBottom = contextSize.height - targetOffset.dy - targetSize.height - _tooltipMinimumHeight / 2;
          break;
        default:
          break;
      }
    } else {
      final tooltipFitsAboveTarget = targetOffset.dy - _tooltipMinimumHeight >= 0;
      final tooltipFitsBelowTarget = targetOffset.dy + targetSize.height + _tooltipMinimumHeight <= contextSize.height;
      _tooltipTop = tooltipFitsAboveTarget
          ? null
          : tooltipFitsBelowTarget
              ? targetOffset.dy + targetSize.height
              : null;
      _tooltipBottom = tooltipFitsAboveTarget
          ? contextSize.height - targetOffset.dy
          : tooltipFitsBelowTarget
              ? null
              : targetOffset.dy + targetSize.height / 2;
    }
    // If the tooltip is below the target, invert the arrow.
    // _isInverted = _tooltipTop != null;
    _isInverted = widget.position == TooltipPosition.bottom;
    // Align the tooltip horizontally relative to the target.
    _tooltipAlignment = Alignment(
      (targetOffset.dx) / (contextSize.width - targetSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );
    // Make the tooltip appear from the target.
    _transitionAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) / contextSize.width * 2 - 1.0,
      _isInverted ? -1.0 : 1.0,
    );
    // Center the arrow horizontally on the target.
    _arrowAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) / (contextSize.width - _arrowSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If the tooltip is delayed, start a timer to show it.
      if (widget.delay != null) {
        _delayTimer = Timer(widget.delay!, _toggle);
      }
    });
    widget.controller?.addListener(_handleControllerChange);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Don't uncomment this code
  // @override
  // void dispose() {
  //   widget.controller?.removeListener(_handleControllerChange);
  //   _delayTimer?.cancel();
  //   _animationController.dispose();
  //   super.dispose();
  // }

  void _handleControllerChange() {
    if (_overlayController.isShowing) {
      _animationController.reverse().then((_) {
        _overlayController.hide();
      });
    } else {
      _updatePosition();
      _overlayController.show();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no theme is provided,
    // use the opposite brightness of the current theme to make the tooltip stand out.
    final theme = widget.theme ??
        ThemeData(
          useMaterial3: true,
          brightness: Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
        );

    return OverlayPortal.targetsRootOverlay(
      controller: _overlayController,
      child: widget.child != null ? GestureDetector(onTap: _toggle, child: widget.child) : null,
      overlayChildBuilder: (context) {
        return Positioned(
          top: _tooltipTop,
          bottom: _tooltipBottom,
          // Provide a transition alignment to make the tooltip appear from the target.
          child: ScaleTransition(
            alignment: _transitionAlignment,
            scale: _scaleAnimation,
            // TapRegion allows the tooltip to be dismissed by tapping outside of it.
            child: TapRegion(
              onTapOutside: (PointerDownEvent event) {
                _toggle();
              },
              // If no theme is provided, a theme with inverted brightness is used.
              child: Theme(
                data: theme,
                // Don't allow the tooltip to get wider than the screen.
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isInverted)
                        Align(
                          alignment: _arrowAlignment,
                          child: TooltipArrow(
                            size: _arrowSize,
                            isInverted: true,
                            color: Colors.white,
                          ),
                        ),
                      Align(
                        alignment: _tooltipAlignment,
                        child: IntrinsicHeight(
                            child: Container(
                          // width: 162,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 60,
                                offset: Offset(30, 21),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: widget.content,
                        )),
                      ),
                      if (!_isInverted)
                        Align(
                          alignment: _arrowAlignment,
                          child: TooltipArrow(
                            size: _arrowSize,
                            isInverted: false,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
