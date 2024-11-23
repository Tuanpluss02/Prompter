import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

showAppBottomSheet({
  required Widget child,
}) {
  final modalRoute = ModalSheetRoute(
    // Enable the swipe-to-dismiss behavior.
    swipeDismissible: true,
    // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
    swipeDismissSensitivity: const SwipeDismissSensitivity(
      minFlingVelocityRatio: 2.0,
      minDragDistance: 200.0,
    ),
    builder: (context) => _AppBottomSheet(child),
  );

  Get.key.currentState?.push(modalRoute);
}

class _AppBottomSheet extends StatelessWidget {
  final Widget child;
  const _AppBottomSheet(this.child);
  @override
  Widget build(BuildContext context) {
    // You can use PopScope to handle the swipe-to-dismiss gestures, as well as
    // the system back gestures and tapping on the barrier, all in one place.
    return DraggableSheet(
      // minPosition: const SheetAnchor.proportional(0.5),
      child: Card(
        color: Color(0xff2c2c2c),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 15),
            child,
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
