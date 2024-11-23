import 'package:base/presentation/shared/chat_view/src/models/config_models/image_message_configuration.dart';
import 'package:flutter/material.dart';

class ShareIcon extends StatelessWidget {
  /// Provides configuration of share icon which is showed in image preview.
  final ShareIconConfiguration? shareIconConfig;

  /// Provides image url of image message.
  final String imageUrl;

  const ShareIcon({
    super.key,
    this.shareIconConfig,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => shareIconConfig?.onPressed != null ? shareIconConfig?.onPressed!(imageUrl) : null,
      padding: shareIconConfig?.margin ?? const EdgeInsets.all(8.0),
      icon: shareIconConfig?.icon ??
          Container(
            alignment: Alignment.center,
            padding: shareIconConfig?.padding ?? const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: shareIconConfig?.defaultIconBackgroundColor ?? Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.send,
              color: shareIconConfig?.defaultIconColor ?? Colors.black,
              size: 16,
            ),
          ),
    );
  }
}
