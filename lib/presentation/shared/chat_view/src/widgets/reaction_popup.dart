import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/glassmorphism_reaction_popup.dart';
import 'package:flutter/material.dart';

import 'emoji_row.dart';

class ReactionPopup extends StatefulWidget {
  /// Provides call back when user taps on reaction pop-up.
  final VoidCallBack onTap;

  /// Represents should pop-up show or not.
  final bool showPopUp;

  const ReactionPopup({
    super.key,
    required this.onTap,
    required this.showPopUp,
  });

  @override
  ReactionPopupState createState() => ReactionPopupState();
}

class ReactionPopupState extends State<ReactionPopup> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: reactionPopupConfig?.animationDuration ?? const Duration(milliseconds: 180),
  );

  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
    reverseCurve: Curves.easeInOutSine,
  );

  double _yCoordinate = 0.0;

  double _xCoordinate = 0.0;
  Message? _message;
  ChatController? chatController;
  ChatUser? currentUser;

  ReactionPopupConfiguration? get reactionPopupConfig => chatListConfig.reactionPopupConfig;
  bool get showPopUp => widget.showPopUp;

  Widget get _reactionPopupRow => EmojiRow(
        onEmojiTap: (emoji) {
          widget.onTap();
          if (currentUser != null && _message != null) {
            if (!(reactionPopupConfig?.overrideUserReactionCallback ?? false)) {
              chatController?.setReaction(
                emoji: emoji,
                messageId: _message!.id,
                userId: currentUser!.id,
              );
            }
            reactionPopupConfig?.userReactionCallback?.call(
              _message!,
              emoji,
            );
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final toolTipWidth = deviceWidth > 450 ? 450 : deviceWidth;
    if (showPopUp) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return showPopUp
        ? Positioned(
            top: _yCoordinate,
            left: _xCoordinate + toolTipWidth > deviceWidth
                ? deviceWidth - toolTipWidth
                : _xCoordinate - (toolTipWidth / 2) < 0
                    ? 0
                    : _xCoordinate - (toolTipWidth / 2),
            child: SizedBox(
              width: deviceWidth > 450 ? 450 : deviceWidth,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: reactionPopupConfig?.showGlassMorphismEffect ?? false
                      ? GlassMorphismReactionPopup(
                          reactionPopupConfig: reactionPopupConfig,
                          child: _reactionPopupRow,
                        )
                      : Container(
                          constraints: BoxConstraints(maxWidth: reactionPopupConfig?.maxWidth ?? 350),
                          margin: reactionPopupConfig?.margin ?? const EdgeInsets.symmetric(horizontal: 25),
                          padding: reactionPopupConfig?.padding ??
                              const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 14,
                              ),
                          decoration: BoxDecoration(
                            color: reactionPopupConfig?.backgroundColor ?? Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              reactionPopupConfig?.shadow ??
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 8,
                                    spreadRadius: -2,
                                    offset: const Offset(0, 8),
                                  )
                            ],
                          ),
                          child: _reactionPopupRow,
                        ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (chatViewIW != null) {
      chatController = chatViewIW!.chatController;
      currentUser = chatController?.currentUser;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void refreshWidget({
    required Message message,
    required double xCoordinate,
    required double yCoordinate,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final yPosition = yCoordinate - (chatViewIW!.reactionPopupKey.currentContext?.size?.height ?? 0);
        _message = message;
        _xCoordinate = xCoordinate;
        _yCoordinate = yPosition < 0 ? 0 : yPosition;
      });
    });
  }
}
