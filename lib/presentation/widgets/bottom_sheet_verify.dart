import 'package:flutter/material.dart';

Future<void> showBottomSheetVerify({
  required BuildContext context,
  required List<Widget> children,
  double initialChildSize = 0.88,
  double minChildSize = 0,
  double maxChildSize = 0.88,
  VoidCallback? onResult,
  required PageController pageController
}) async {
  final result = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (BuildContext context, ScrollController sheetScrollController) {
            return GestureDetector(
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: PageView(controller: pageController, physics: const NeverScrollableScrollPhysics(), children: children),
              ),
            );
          },
        ),
      );
    },
  );

  if (result == true || result == null) {
    onResult?.call();
  }
}