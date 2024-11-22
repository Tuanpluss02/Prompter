import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/suggestions/suggestion_list.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/type_indicator_widget.dart';
import 'package:flutter/material.dart';

import 'chat_bubble_widget.dart';
import 'chat_group_header.dart';

class ChatGroupedListWidget extends StatefulWidget {
  /// Allow user to swipe to see time while reaction pop is not open.
  final bool showPopUp;

  /// Pass scroll controller
  final ScrollController scrollController;

  /// Provides reply message if actual message is sent by replying any message.
  final ReplyMessage replyMessage;

  /// Provides callback for assigning reply message when user swipe on chat bubble.
  final MessageCallBack assignReplyMessage;

  /// Provides callback when user tap anywhere on whole chat.
  final VoidCallBack onChatListTap;

  /// Provides callback when user press chat bubble for certain time then usual.
  final void Function(double, double, Message) onChatBubbleLongPress;

  /// Provide flag for turn on/off to see message crated time view when user
  /// swipe whole chat.
  final bool isEnableSwipeToSeeTime;

  const ChatGroupedListWidget({
    super.key,
    required this.showPopUp,
    required this.scrollController,
    required this.replyMessage,
    required this.assignReplyMessage,
    required this.onChatListTap,
    required this.onChatBubbleLongPress,
    required this.isEnableSwipeToSeeTime,
  });

  @override
  State<ChatGroupedListWidget> createState() => _ChatGroupedListWidgetState();
}

class _ChatGroupedListWidgetState extends State<ChatGroupedListWidget> with TickerProviderStateMixin {
  bool highlightMessage = false;

  final ValueNotifier<String?> _replyId = ValueNotifier(null);
  AnimationController? _animationController;

  Animation<Offset>? _slideAnimation;
  FeatureActiveConfig? featureActiveConfig;

  ChatController? chatController;

  double chatTextFieldHeight = 0;

  ChatBackgroundConfiguration get chatBackgroundConfig => chatListConfig.chatBackgroundConfig;

  bool get isEnableSwipeToSeeTime => widget.isEnableSwipeToSeeTime;

  bool get showPopUp => widget.showPopUp;

  Widget get _chatStreamBuilder {
    DateTime lastMatchedDate = DateTime.now();
    return StreamBuilder<List<Message>>(
      stream: chatController?.messageStreamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.connectionState.isActive) {
          return Center(
            child: chatBackgroundConfig.loadingWidget ?? const CircularProgressIndicator(),
          );
        } else {
          final messages = chatBackgroundConfig.sortEnable ? sortMessage(snapshot.data!) : snapshot.data!;

          final enableSeparator = featureActiveConfig?.enableChatSeparator ?? false;

          Map<int, DateTime> messageSeparator = {};

          if (enableSeparator) {
            /// Get separator when date differ for two messages
            (messageSeparator, lastMatchedDate) = _getMessageSeparator(
              messages,
              lastMatchedDate,
            );
          }

          /// [count] that indicates how many separators
          /// needs to be display in chat
          var count = 0;

          return ListView.builder(
            key: widget.key,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: (enableSeparator ? messages.length + messageSeparator.length : messages.length),
            itemBuilder: (context, index) {
              /// By removing [count] from [index] will get actual index
              /// to display message in chat
              var newIndex = index - count;

              /// Check [messageSeparator] contains group separator for [index]
              if (enableSeparator && messageSeparator.containsKey(index)) {
                /// Increase counter each time
                /// after separating messages with separator
                count++;
                return _groupSeparator(
                  messageSeparator[index]!,
                );
              }

              return ValueListenableBuilder<String?>(
                valueListenable: _replyId,
                builder: (context, state, child) {
                  final message = messages[newIndex];
                  final enableScrollToRepliedMsg = chatListConfig.repliedMessageConfig?.repliedMsgAutoScrollConfig.enableScrollToRepliedMsg ?? false;
                  return ChatBubbleWidget(
                    key: message.key,
                    message: message,
                    slideAnimation: _slideAnimation,
                    onLongPress: (yCoordinate, xCoordinate) => widget.onChatBubbleLongPress(
                      yCoordinate,
                      xCoordinate,
                      message,
                    ),
                    onSwipe: widget.assignReplyMessage,
                    shouldHighlight: state == message.id,
                    onReplyTap: enableScrollToRepliedMsg ? (replyId) => _onReplyTap(replyId, snapshot.data) : null,
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsListConfig = suggestionsConfig?.listConfig ?? const SuggestionListConfig();
    return SingleChildScrollView(
      reverse: true,
      // When reaction popup is being appeared at that user should not scroll.
      physics: showPopUp ? const NeverScrollableScrollPhysics() : null,
      controller: widget.scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) => isEnableSwipeToSeeTime && !showPopUp ? _onHorizontalDrag(details) : null,
            onHorizontalDragEnd: (details) => isEnableSwipeToSeeTime && !showPopUp ? _animationController?.reverse() : null,
            onTap: widget.onChatListTap,
            child: _animationController != null
                ? AnimatedBuilder(
                    animation: _animationController!,
                    builder: (context, child) {
                      return _chatStreamBuilder;
                    },
                  )
                : _chatStreamBuilder,
          ),
          if (chatController != null)
            ValueListenableBuilder(
              valueListenable: chatController!.typingIndicatorNotifier,
              builder: (context, value, child) => TypingIndicator(
                typeIndicatorConfig: chatListConfig.typeIndicatorConfig,
                chatBubbleConfig: chatListConfig.chatBubbleConfig?.inComingChatBubbleConfig,
                showIndicator: value,
              ),
            ),
          if (chatController != null)
            Flexible(
              child: Align(
                alignment: suggestionsListConfig.axisAlignment.alignment,
                child: const SuggestionList(),
              ),
            ),

          // Adds bottom space to the message list, ensuring it is displayed
          // above the message text field.
          SizedBox(
            height: chatTextFieldHeight,
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (chatViewIW != null) {
      featureActiveConfig = chatViewIW!.featureActiveConfig;
      chatController = chatViewIW!.chatController;
    }
    _initializeAnimation();
  }

  @override
  void didUpdateWidget(covariant ChatGroupedListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateChatTextFieldHeight();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _replyId.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    updateChatTextFieldHeight();
  }

  List<Message> sortMessage(List<Message> messages) {
    final elements = [...messages];
    elements.sort(
      chatBackgroundConfig.messageSorter ?? (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    if (chatBackgroundConfig.groupedListOrder.isAsc) {
      return elements.toList();
    } else {
      return elements.reversed.toList();
    }
  }

  void updateChatTextFieldHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        chatTextFieldHeight = chatViewIW?.chatTextFieldViewKey.currentContext?.size?.height ?? 10;
      });
    });
  }

  GetMessageSeparator _getMessageSeparator(
    List<Message> messages,
    DateTime lastDate,
  ) {
    final messageSeparator = <int, DateTime>{};
    var lastMatchedDate = lastDate;
    var counter = 0;

    /// Holds index and separator mapping to display in chat
    for (var i = 0; i < messages.length; i++) {
      if (messageSeparator.isEmpty) {
        /// Separator for initial message
        messageSeparator[0] = messages[0].createdAt;
        continue;
      }
      lastMatchedDate = _groupBy(
        messages[i],
        lastMatchedDate,
      );
      var previousDate = _groupBy(
        messages[i - 1],
        lastMatchedDate,
      );

      if (previousDate != lastMatchedDate) {
        /// Group separator when previous message and
        /// current message time differ
        counter++;

        messageSeparator[i + counter] = messages[i].createdAt;
      }
    }

    return (messageSeparator, lastMatchedDate);
  }

  /// return DateTime by checking lastMatchedDate and message created DateTime
  DateTime _groupBy(
    Message message,
    DateTime lastMatchedDate,
  ) {
    /// If the conversation is ongoing on the same date,
    /// return the same date [lastMatchedDate].

    /// When the conversation starts on a new date,
    /// we are returning new date [message.createdAt].
    return lastMatchedDate.getDateFromDateTime == message.createdAt.getDateFromDateTime ? lastMatchedDate : message.createdAt;
  }

  Widget _groupSeparator(DateTime createdAt) {
    return featureActiveConfig?.enableChatSeparator ?? false
        ? _GroupSeparatorBuilder(
            separator: createdAt,
            defaultGroupSeparatorConfig: chatBackgroundConfig.defaultGroupSeparatorConfig,
            groupSeparatorBuilder: chatBackgroundConfig.groupSeparatorBuilder,
          )
        : const SizedBox.shrink();
  }

  void _initializeAnimation() {
    // When this flag is on at that time only animation controllers will be
    // initialized.
    if (isEnableSwipeToSeeTime) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
      );
      _slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          curve: Curves.decelerate,
          parent: _animationController!,
        ),
      );
    }
  }

  /// When user swipe at that time only animation is assigned with value.
  void _onHorizontalDrag(DragUpdateDetails details) {
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(
      CurvedAnimation(
        curve: chatBackgroundConfig.messageTimeAnimationCurve,
        parent: _animationController!,
      ),
    );

    details.delta.dx > 1 ? _animationController?.reverse() : _animationController?.forward();
  }

  Future<void> _onReplyTap(String id, List<Message>? messages) async {
    // Finds the replied message if exists
    final repliedMessages = messages?.firstWhere((message) => id == message.id);
    final repliedMsgAutoScrollConfig = chatListConfig.repliedMessageConfig?.repliedMsgAutoScrollConfig;
    final highlightDuration = repliedMsgAutoScrollConfig?.highlightDuration ?? const Duration(milliseconds: 300);
    // Scrolls to replied message and highlights
    if (repliedMessages != null && repliedMessages.key.currentState != null) {
      await Scrollable.ensureVisible(
        repliedMessages.key.currentState!.context,
        // This value will make widget to be in center when auto scrolled.
        alignment: 0.5,
        curve: repliedMsgAutoScrollConfig?.highlightScrollCurve ?? Curves.easeIn,
        duration: highlightDuration,
      );
      if (repliedMsgAutoScrollConfig?.enableHighlightRepliedMsg ?? false) {
        _replyId.value = id;

        Future.delayed(highlightDuration, () {
          _replyId.value = null;
        });
      }
    }
  }
}

class _GroupSeparatorBuilder extends StatelessWidget {
  final DateTime separator;
  final StringWithReturnWidget? groupSeparatorBuilder;
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;
  const _GroupSeparatorBuilder({
    required this.separator,
    this.groupSeparatorBuilder,
    this.defaultGroupSeparatorConfig,
  });

  @override
  Widget build(BuildContext context) {
    return groupSeparatorBuilder != null
        ? groupSeparatorBuilder!(separator.toString())
        : ChatGroupHeader(
            day: separator,
            groupSeparatorConfig: defaultGroupSeparatorConfig,
          );
  }
}
