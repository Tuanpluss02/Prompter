import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/models/chat_bubble.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/link_preview_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/message_reaction_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/data_models/message.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import 'link_preview.dart';
import 'reaction_widget.dart';

class TextMessageView extends StatelessWidget {
  /// Represents current message is sent by current user.
  final bool isMessageBySender;

  /// Provides message instance of chat.
  final Message message;

  /// Allow users to give max width of chat bubble.
  final double? chatBubbleMaxWidth;

  /// Provides configuration of chat bubble appearance from other user of chat.
  final ChatBubble? inComingChatBubbleConfig;

  /// Provides configuration of chat bubble appearance from current user of chat.
  final ChatBubble? outgoingChatBubbleConfig;

  /// Provides configuration of reaction appearance in chat bubble.
  final MessageReactionConfiguration? messageReactionConfig;

  /// Represents message should highlight.
  final bool highlightMessage;

  /// Allow user to set color of highlighted message.
  final Color? highlightColor;

  const TextMessageView({
    super.key,
    required this.isMessageBySender,
    required this.message,
    this.chatBubbleMaxWidth,
    this.inComingChatBubbleConfig,
    this.outgoingChatBubbleConfig,
    this.messageReactionConfig,
    this.highlightMessage = false,
    this.highlightColor,
  });

  Color get _color => isMessageBySender ? outgoingChatBubbleConfig?.color ?? Colors.purple : inComingChatBubbleConfig?.color ?? Colors.grey.shade500;

  LinkPreviewConfiguration? get _linkPreviewConfig => isMessageBySender ? outgoingChatBubbleConfig?.linkPreviewConfig : inComingChatBubbleConfig?.linkPreviewConfig;

  EdgeInsetsGeometry? get _margin => isMessageBySender ? outgoingChatBubbleConfig?.margin : inComingChatBubbleConfig?.margin;

  EdgeInsetsGeometry? get _padding => isMessageBySender ? outgoingChatBubbleConfig?.padding : inComingChatBubbleConfig?.padding;

  TextStyle? get _textStyle => isMessageBySender ? outgoingChatBubbleConfig?.textStyle : inComingChatBubbleConfig?.textStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textMessage = message.message;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: chatBubbleMaxWidth ?? MediaQuery.of(context).size.width * 0.75),
          padding: _padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
          margin: _margin ?? EdgeInsets.fromLTRB(5, 0, 6, message.reaction.reactions.isNotEmpty ? 15 : 2),
          decoration: BoxDecoration(
            color: highlightMessage ? highlightColor : _color,
            borderRadius: _borderRadius(textMessage),
          ),
          child: textMessage.isUrl
              ? LinkPreview(
                  linkPreviewConfig: _linkPreviewConfig,
                  url: textMessage,
                )
              : SelectableText(
                  textMessage,
                  style: _textStyle ??
                      textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
        ),
        if (message.reaction.reactions.isNotEmpty)
          ReactionWidget(
            key: key,
            isMessageBySender: isMessageBySender,
            reaction: message.reaction,
            messageReactionConfig: messageReactionConfig,
          ),
      ],
    );
  }

  BorderRadiusGeometry _borderRadius(String message) => isMessageBySender
      ? outgoingChatBubbleConfig?.borderRadius ?? (message.length < 37 ? BorderRadius.circular(replyBorderRadius1) : BorderRadius.circular(replyBorderRadius2))
      : inComingChatBubbleConfig?.borderRadius ?? (message.length < 29 ? BorderRadius.circular(replyBorderRadius1) : BorderRadius.circular(replyBorderRadius2));
}
