import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import '../utils/package_strings.dart';
import 'chat_view_inherited_widget.dart';
import 'vertical_line.dart';

class ReplyMessageWidget extends StatelessWidget {
  /// Provides message instance of chat.
  final Message message;

  /// Provides configurations related to replied message such as textstyle
  /// padding, margin etc. Also, this widget is located upon chat bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides call back when user taps on replied message.
  final VoidCallback? onTap;

  const ReplyMessageWidget({
    super.key,
    required this.message,
    this.repliedMessageConfig,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chatController = ChatViewInheritedWidget.of(context)?.chatController;
    final currentUser = chatController?.currentUser;
    final replyBySender = message.replyMessage.replyBy == currentUser?.id;
    final textTheme = Theme.of(context).textTheme;
    final replyMessage = message.replyMessage.message;
    final messagedUser = chatController?.getUserFromId(message.replyMessage.replyBy);
    final replyBy = replyBySender ? PackageStrings.you : messagedUser?.name;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: repliedMessageConfig?.margin ??
            const EdgeInsets.only(
              right: horizontalPadding,
              left: horizontalPadding,
              bottom: 4,
            ),
        constraints: BoxConstraints(maxWidth: repliedMessageConfig?.maxWidth ?? 280),
        child: Column(
          crossAxisAlignment: replyBySender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              "${PackageStrings.repliedBy} $replyBy",
              style: repliedMessageConfig?.replyTitleTextStyle ?? textTheme.bodyMedium!.copyWith(fontSize: 14, letterSpacing: 0.3),
            ),
            const SizedBox(height: 6),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: replyBySender ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!replyBySender)
                    VerticalLine(
                      verticalBarWidth: repliedMessageConfig?.verticalBarWidth,
                      verticalBarColor: repliedMessageConfig?.verticalBarColor,
                      rightPadding: 4,
                    ),
                  Flexible(
                    child: Opacity(
                      opacity: repliedMessageConfig?.opacity ?? 0.8,
                      child: message.replyMessage.messageType.isImage
                          ? Container(
                              height: repliedMessageConfig?.repliedImageMessageHeight ?? 100,
                              width: repliedMessageConfig?.repliedImageMessageWidth ?? 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(replyMessage),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: repliedMessageConfig?.borderRadius ?? BorderRadius.circular(14),
                              ),
                            )
                          : Container(
                              constraints: BoxConstraints(
                                maxWidth: repliedMessageConfig?.maxWidth ?? 280,
                              ),
                              padding: repliedMessageConfig?.padding ??
                                  const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                              decoration: BoxDecoration(
                                borderRadius: _borderRadius(
                                  replyMessage: replyMessage,
                                  replyBySender: replyBySender,
                                ),
                                color: repliedMessageConfig?.backgroundColor ?? Colors.grey.shade500,
                              ),
                              child: message.replyMessage.messageType.isVoice
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.mic,
                                          color: repliedMessageConfig?.micIconColor ?? Colors.white,
                                        ),
                                        const SizedBox(width: 2),
                                        if (message.replyMessage.voiceMessageDuration != null)
                                          Text(
                                            message.replyMessage.voiceMessageDuration!.toHHMMSS(),
                                            style: repliedMessageConfig?.textStyle,
                                          ),
                                      ],
                                    )
                                  : Text(
                                      replyMessage,
                                      style: repliedMessageConfig?.textStyle ?? textTheme.bodyMedium!.copyWith(color: Colors.black),
                                    ),
                            ),
                    ),
                  ),
                  if (replyBySender)
                    VerticalLine(
                      verticalBarWidth: repliedMessageConfig?.verticalBarWidth,
                      verticalBarColor: repliedMessageConfig?.verticalBarColor,
                      leftPadding: 4,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BorderRadiusGeometry _borderRadius({
    required String replyMessage,
    required bool replyBySender,
  }) =>
      replyBySender
          ? repliedMessageConfig?.borderRadius ?? (replyMessage.length < 37 ? BorderRadius.circular(replyBorderRadius1) : BorderRadius.circular(replyBorderRadius2))
          : repliedMessageConfig?.borderRadius ?? (replyMessage.length < 29 ? BorderRadius.circular(replyBorderRadius1) : BorderRadius.circular(replyBorderRadius2));
}
