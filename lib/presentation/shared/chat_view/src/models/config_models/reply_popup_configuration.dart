import 'package:flutter/material.dart';

import '../../values/typedefs.dart';
import '../data_models/message.dart';

class ReplyPopupConfiguration {
  /// Used for giving background color to reply snack-bar.
  final Color? backgroundColor;

  /// Provides builder for creating reply pop-up widget.
  final Widget Function(Message message, bool sentByCurrentUser)? replyPopupBuilder;

  /// Provides callback on unSend button.
  final MessageCallBack? onUnsendTap;

  /// Provides callback on onReply button.
  final MessageCallBack? onReplyTap;

  /// Provides callback on onReport button.
  final MessageCallBack? onReportTap;

  /// Provides callback on onMore button.
  final MoreTapCallBack? onMoreTap;

  /// Used to give text style of button text.
  final TextStyle? buttonTextStyle;

  /// Used to give color to top side border of reply snack bar.
  final Color? topBorderColor;

  const ReplyPopupConfiguration({
    this.buttonTextStyle,
    this.topBorderColor,
    this.onUnsendTap,
    this.onReplyTap,
    this.onReportTap,
    this.onMoreTap,
    this.backgroundColor,
    this.replyPopupBuilder,
  });
}
