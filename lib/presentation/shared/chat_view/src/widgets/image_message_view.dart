import 'dart:convert';
import 'dart:io';

import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/image_message_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/message_reaction_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/data_models/message.dart';
import 'package:base/presentation/shared/utils/full_screen_image_view.dart';
import 'package:flutter/material.dart';

import 'reaction_widget.dart';
import 'share_icon.dart';

class ImageMessageView extends StatelessWidget {
  /// Provides message instance of chat.
  final Message message;

  /// Represents current message is sent by current user.
  final bool isMessageBySender;

  /// Provides configuration for image message appearance.
  final ImageMessageConfiguration? imageMessageConfig;

  /// Provides configuration of reaction appearance in chat bubble.
  final MessageReactionConfiguration? messageReactionConfig;

  /// Represents flag of highlighting image when user taps on replied image.
  final bool highlightImage;

  /// Provides scale of highlighted image when user taps on replied image.
  final double highlightScale;

  const ImageMessageView({
    super.key,
    required this.message,
    required this.isMessageBySender,
    this.imageMessageConfig,
    this.messageReactionConfig,
    this.highlightImage = false,
    this.highlightScale = 1.2,
  });

  Widget get iconButton => ShareIcon(
        shareIconConfig: imageMessageConfig?.shareIconConfig,
        imageUrl: imageUrl,
      );

  String get imageUrl => message.message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMessageBySender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isMessageBySender && !(imageMessageConfig?.hideShareIcon ?? false)) iconButton,
        Stack(
          children: [
            Transform.scale(
              scale: highlightImage ? highlightScale : 1.0,
              alignment: isMessageBySender ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: imageMessageConfig?.padding ?? EdgeInsets.zero,
                margin: imageMessageConfig?.margin ??
                    EdgeInsets.only(
                      top: 6,
                      right: isMessageBySender ? 6 : 0,
                      left: isMessageBySender ? 0 : 6,
                      bottom: message.reaction.reactions.isNotEmpty ? 15 : 0,
                    ),
                height: imageMessageConfig?.height ?? 200,
                width: imageMessageConfig?.width ?? 150,
                child: ClipRRect(
                  borderRadius: imageMessageConfig?.borderRadius ?? BorderRadius.circular(14),
                  child: (() {
                    if (imageUrl.isUrl) {
                      return FullScreenWidget(
                          imageUrl: imageUrl,
                          disposeLevel: DisposeLevel.medium,
                          child: Hero(
                              tag: imageUrl,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                    ),
                                  );
                                },
                              )));
                    } else if (imageUrl.fromMemory) {
                      return Image.memory(
                        base64Decode(imageUrl.substring(imageUrl.indexOf('base64') + 7)),
                        fit: BoxFit.fill,
                      );
                    } else {
                      return Image.file(
                        File(imageUrl),
                        fit: BoxFit.fill,
                      );
                    }
                  }()),
                ),
              ),
            ),
            if (message.reaction.reactions.isNotEmpty)
              ReactionWidget(
                isMessageBySender: isMessageBySender,
                reaction: message.reaction,
                messageReactionConfig: messageReactionConfig,
              ),
          ],
        ),
        if (!isMessageBySender && !(imageMessageConfig?.hideShareIcon ?? false)) iconButton,
      ],
    );
  }
}
