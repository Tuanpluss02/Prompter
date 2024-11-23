import 'package:base/presentation/shared/chat_view/src/models/config_models/emoji_message_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/image_message_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/message_reaction_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/voice_message_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/models/data_models/message.dart';
import 'package:flutter/material.dart';

import '../../values/typedefs.dart';

class MessageConfiguration {
  /// Provides configuration of image message appearance.
  final ImageMessageConfiguration? imageMessageConfig;

  /// Provides configuration of image message appearance.
  final MessageReactionConfiguration? messageReactionConfig;

  /// Provides configuration of emoji messages appearance.
  final EmojiMessageConfiguration? emojiMessageConfig;

  /// Provides builder to create view for custom messages.
  final Widget Function(Message)? customMessageBuilder;

  /// Configurations for voice message bubble
  final VoiceMessageConfiguration? voiceMessageConfig;

  /// To customize reply view for custom message type
  final CustomMessageReplyViewBuilder? customMessageReplyViewBuilder;

  const MessageConfiguration({
    this.imageMessageConfig,
    this.messageReactionConfig,
    this.emojiMessageConfig,
    this.customMessageBuilder,
    this.voiceMessageConfig,
    this.customMessageReplyViewBuilder,
  });
}
