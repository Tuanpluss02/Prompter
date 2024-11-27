import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class AppOverlay {
  static OverlayEntry? overlayEntry;
  static createHighlightOverlay({
    required BuildContext context,
    Widget? child,
  }) {
    removeHighlightOverlay();
    OverlayState overlayState = Overlay.of(context);
    assert(overlayEntry == null);
    Widget title = Text(
      AppStrings.appName.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Larsseit',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
      ),
    );

    title = title.animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: AppColors.primaryColor).animate();
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Center(
          child: child ??
              Container(
                height: 64,
                width: 150,
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                child: Center(child: title),
              ),
        );
      },
    );

    overlayState.insert(overlayEntry!);
  }

  static removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  static Future<T> showLoading<T>({required Future<T> api, child}) async {
    createHighlightOverlay(context: Get.context!, child: child);
    Stopwatch stopwatch = Stopwatch()..start();
    final result = await api;
    stopwatch.stop();
    if (stopwatch.elapsedMilliseconds < 200) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    removeHighlightOverlay();
    return result;
  }
}
