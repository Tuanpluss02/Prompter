import 'package:flutter/material.dart';

class SwipeToReplyConfiguration {
  /// Used to give color of reply icon while swipe to reply.
  final Color? replyIconColor;

  /// Used to give color of circular progress around reply icon while swipe to reply.
  final Color? replyIconProgressRingColor;

  /// Used to give color of reply icon background when swipe to reply reach swipe limit.
  final Color? replyIconBackgroundColor;

  /// Provides callback when user swipe chat bubble from left side.
  final void Function(String message, String sentBy)? onLeftSwipe;

  /// Provides callback when user swipe chat bubble from right side.
  final void Function(String message, String sentBy)? onRightSwipe;

  const SwipeToReplyConfiguration({
    this.replyIconColor,
    this.replyIconProgressRingColor,
    this.replyIconBackgroundColor,
    this.onRightSwipe,
    this.onLeftSwipe,
  });
}
