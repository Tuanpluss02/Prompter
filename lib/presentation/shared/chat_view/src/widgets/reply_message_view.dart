import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/package_strings.dart';
import '../values/enumeration.dart';
import '../values/typedefs.dart';

class ReplyMessageView extends StatelessWidget {
  const ReplyMessageView({
    super.key,
    required this.message,
    this.customMessageReplyViewBuilder,
    this.sendMessageConfig,
  });

  final ReplyMessage message;

  final CustomMessageReplyViewBuilder? customMessageReplyViewBuilder;
  final SendMessageConfiguration? sendMessageConfig;

  @override
  Widget build(BuildContext context) {
    return switch (message.messageType) {
      MessageType.voice => Row(
          children: [
            Icon(
              Icons.mic,
              color: sendMessageConfig?.micIconColor,
            ),
            const SizedBox(width: 4),
            if (message.voiceMessageDuration != null)
              Text(
                message.voiceMessageDuration!.toHHMMSS(),
                style: TextStyle(
                  fontSize: 12,
                  color: sendMessageConfig?.replyMessageColor ?? Colors.black,
                ),
              ),
          ],
        ),
      MessageType.image => Row(
          children: [
            Icon(
              Icons.photo,
              size: 20,
              color: sendMessageConfig?.replyMessageColor ?? Colors.grey.shade700,
            ),
            Text(
              PackageStrings.photo,
              style: TextStyle(
                color: sendMessageConfig?.replyMessageColor ?? Colors.black,
              ),
            ),
          ],
        ),
      MessageType.custom when customMessageReplyViewBuilder != null => customMessageReplyViewBuilder!(message),
      MessageType.custom || MessageType.text => Text(
          message.message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: sendMessageConfig?.replyMessageColor ?? Colors.black,
          ),
        ),
    };
  }
}
