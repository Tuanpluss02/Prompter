import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../values/typedefs.dart';
import 'emoji_picker_widget.dart';

class EmojiRow extends StatelessWidget {
  /// Provides callback when user taps on emoji in reaction pop-up.
  final StringCallback onEmojiTap;

  /// These are default emojis.
  final List<String> _emojiUnicodes = [
    heart,
    faceWithTears,
    astonishedFace,
    disappointedFace,
    angryFace,
    thumbsUp,
  ];

  EmojiRow({
    super.key,
    required this.onEmojiTap,
  });

  @override
  Widget build(BuildContext context) {
    final emojiConfig = context.chatListConfig.reactionPopupConfig?.emojiConfig;
    final emojiList = emojiConfig?.emojiList ?? _emojiUnicodes;
    final size = emojiConfig?.size;
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              emojiList.length,
              (index) => GestureDetector(
                onTap: () => onEmojiTap(emojiList[index]),
                child: Text(
                  emojiList[index],
                  style: TextStyle(fontSize: size ?? 28),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.add,
            color: Colors.grey.shade600,
            size: size ?? 28,
          ),
          onPressed: () => _showBottomSheet(context),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        builder: (newContext) => EmojiPickerWidget(
          emojiPickerSheetConfig: context.chatListConfig.emojiPickerSheetConfig,
          onSelected: (emoji) {
            Navigator.pop(newContext);
            onEmojiTap(emoji);
          },
        ),
      );
}
