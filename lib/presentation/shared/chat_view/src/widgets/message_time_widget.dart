import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MessageTimeWidget extends StatelessWidget {
  /// Provides message crated date time.
  final DateTime messageTime;

  /// Represents message is sending by current user.
  final bool isCurrentUser;

  const MessageTimeWidget({
    super.key,
    required this.messageTime,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final chatBackgroundConfig = context.chatListConfig.chatBackgroundConfig;
    final messageTimeIconColor = chatBackgroundConfig.messageTimeIconColor ?? Colors.black;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: messageTimeIconColor,
                ),
              ),
              child: Icon(
                isCurrentUser ? Icons.arrow_forward : Icons.arrow_back,
                size: 10,
                color: messageTimeIconColor,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              messageTime.getTimeFromDateTime,
              style: chatBackgroundConfig.messageTimeTextStyle ?? const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
