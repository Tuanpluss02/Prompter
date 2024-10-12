import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/presentation/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

void showBadgeNotification({
  required BuildContext context,
  required String title,
  required String content,
  Widget? prefixWidget,
  Widget? suffixWidget,
  Duration timeAnimation = const Duration(milliseconds: 500),
  Duration timeShowBadgeNotification = const Duration(milliseconds: 1500),
}) {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        right: 0,
        top: 58,
        width: 286,
        height: 63,
        child: CustomSnackBarContent(
          title: title,
          content: content,
          prefixWidget: prefixWidget,
          suffixWidget: suffixWidget,
          timeAnimation: timeAnimation.inMilliseconds,
          timeshowBadgeNotification: timeShowBadgeNotification.inMilliseconds,
        ),
      );
    },
  );

  overlayState.insert(overlayEntry);

  Future.delayed(
      Duration(
          milliseconds: timeAnimation.inMilliseconds * 2 +
              timeShowBadgeNotification.inMilliseconds), () {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  });
}

class CustomSnackBarContent extends StatefulWidget {
  final String title;
  final String content;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final int timeAnimation;

  /// milliseconds
  final int timeshowBadgeNotification;

  /// milliseconds
  const CustomSnackBarContent({
    super.key,
    required this.title,
    required this.content,
    this.prefixWidget,
    this.suffixWidget,
    required this.timeAnimation,
    required this.timeshowBadgeNotification,
  });

  @override
  State<CustomSnackBarContent> createState() {
    return _CustomSnackBarState();
  }
}

class _CustomSnackBarState extends State<CustomSnackBarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.timeAnimation),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));

    _controller.forward().then(
      (value) {
        Future.delayed(Duration(milliseconds: widget.timeshowBadgeNotification))
            .then(
          (value) {
            _controller.reverse();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 14,
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                widget.prefixWidget != null
                    ? widget.prefixWidget!
                    : const SizedBox.shrink(),
                SizedBox(width: widget.prefixWidget != null ? 8 : 0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.s14w700,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (widget.content.isNotEmpty) ...[
                        const SizedBox(height: 1),
                        GradientText(
                          widget.content,
                          gradient: const LinearGradient(colors: [
                            AppColors.yellowEAA902,
                            AppColors.purpleBB47FF,
                          ]),
                          style: AppTextStyles.s12w700,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: widget.suffixWidget != null ? 8 : 0),
                widget.suffixWidget != null
                    ? widget.suffixWidget!
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
