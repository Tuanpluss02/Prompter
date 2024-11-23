import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ReplyIcon extends StatelessWidget {
  /// Represents scale animation value of icon when user swipes for reply.
  final double animationValue;

  /// Allow user to set color of icon which is appeared when user swipes for reply.
  final double replyIconSize;

  const ReplyIcon({
    super.key,
    required this.animationValue,
    this.replyIconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final swipeToReplyConfig = context.chatListConfig.swipeToReplyConfig;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(replyIconSize),
            color: animationValue >= 1.0 ? swipeToReplyConfig?.replyIconBackgroundColor ?? Colors.grey.shade300 : Colors.transparent,
          ),
          height: replyIconSize,
          width: replyIconSize,
          child: CircularProgressIndicator(
            value: animationValue,
            backgroundColor: Colors.transparent,
            strokeWidth: 1.5,
            color: swipeToReplyConfig?.replyIconProgressRingColor ?? Colors.grey.shade300,
          ),
        ),
        Transform.scale(
          scale: animationValue,
          child: Icon(
            Icons.reply_rounded,
            color: swipeToReplyConfig?.replyIconColor ?? Colors.black,
            size: replyIconSize - 5,
          ),
        ),
      ],
    );
  }
}
