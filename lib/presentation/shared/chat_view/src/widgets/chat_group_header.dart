import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/message_list_configuration.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class ChatGroupHeader extends StatelessWidget {
  /// Provides day of started chat.
  final DateTime day;

  /// Provides configuration for separator upon date wise chat.
  final DefaultGroupSeparatorConfiguration? groupSeparatorConfig;

  const ChatGroupHeader({
    super.key,
    required this.day,
    this.groupSeparatorConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: groupSeparatorConfig?.padding ?? const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        day.getDay(
          groupSeparatorConfig?.chatSeparatorDatePattern ?? defaultChatSeparatorDatePattern,
        ),
        textAlign: TextAlign.center,
        style: groupSeparatorConfig?.textStyle ?? const TextStyle(fontSize: 17),
      ),
    );
  }
}
