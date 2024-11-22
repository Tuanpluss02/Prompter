import 'dart:async';
import 'dart:io' if (kIsWeb) 'dart:html';

import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/chat_groupedlist_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../chatview.dart';
import 'reply_popup_widget.dart';

class ChatListWidget extends StatefulWidget {
  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides widget for loading view while pagination is enabled.
  final Widget? loadingWidget;

  /// Provides reply message when user swipe to chat bubble.
  final ReplyMessage replyMessage;

  /// Provides callback when user actions reaches to top and needs to load more
  /// chat
  final VoidCallBackWithFuture? loadMoreData;

  /// Provides flag if there is no more next data left in list.
  final bool? isLastPage;

  /// Provides callback for assigning reply message when user swipe to chat
  /// bubble.
  final MessageCallBack assignReplyMessage;

  /// Provides callback when user tap anywhere on whole chat.
  final VoidCallBack? onChatListTap;

  const ChatListWidget({
    super.key,
    required this.chatController,
    required this.assignReplyMessage,
    required this.replyMessage,
    this.loadingWidget,
    this.loadMoreData,
    this.isLastPage,
    this.onChatListTap,
  });

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _isNextPageLoading = ValueNotifier<bool>(false);

  FeatureActiveConfig? featureActiveConfig;

  ChatUser? currentUser;

  ChatController get chatController => widget.chatController;

  List<Message> get messageList => chatController.initialMessageList;
  ScrollController get scrollController => chatController.scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isNextPageLoading,
          builder: (_, isNextPageLoading, child) {
            if (isNextPageLoading && (featureActiveConfig?.enablePagination ?? false)) {
              return SizedBox(
                height: Scaffold.of(context).appBarMaxHeight,
                child: Center(
                  child: widget.loadingWidget ?? const CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: chatViewIW!.showPopUp,
            builder: (_, showPopupValue, child) {
              return Stack(
                children: [
                  ChatGroupedListWidget(
                    showPopUp: showPopupValue,
                    scrollController: scrollController,
                    isEnableSwipeToSeeTime: featureActiveConfig?.enableSwipeToSeeTime ?? true,
                    assignReplyMessage: widget.assignReplyMessage,
                    replyMessage: widget.replyMessage,
                    onChatBubbleLongPress: (yCoordinate, xCoordinate, message) {
                      if (featureActiveConfig?.enableReactionPopup ?? false) {
                        chatViewIW?.reactionPopupKey.currentState?.refreshWidget(
                          message: message,
                          xCoordinate: xCoordinate,
                          yCoordinate: yCoordinate,
                        );
                        chatViewIW?.showPopUp.value = true;
                      }
                      if (featureActiveConfig?.enableReplySnackBar ?? false) {
                        _showReplyPopup(
                          message: message,
                          sentByCurrentUser: message.sentBy == currentUser?.id,
                        );
                      }
                    },
                    onChatListTap: _onChatListTap,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (chatViewIW != null) {
      featureActiveConfig = chatViewIW!.featureActiveConfig;
      currentUser = chatViewIW!.chatController.currentUser;
    }
    if (featureActiveConfig?.enablePagination ?? false) {
      // When flag is on then it will include pagination logic to scroll
      // controller.
      scrollController.addListener(_pagination);
    }
  }

  @override
  void dispose() {
    chatController.messageStreamController.close();
    scrollController.dispose();
    _isNextPageLoading.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    chatController.messageStreamController = StreamController();
    if (!chatController.messageStreamController.isClosed) {
      chatController.messageStreamController.sink.add(messageList);
    }
    if (messageList.isNotEmpty) chatController.scrollToLastMessage();
  }

  void _onChatListTap() {
    widget.onChatListTap?.call();
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      FocusScope.of(context).unfocus();
    }
    chatViewIW?.showPopUp.value = false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void _pagination() {
    if (widget.loadMoreData == null || widget.isLastPage == true) return;
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent) && !_isNextPageLoading.value) {
      _isNextPageLoading.value = true;
      widget.loadMoreData!().whenComplete(() => _isNextPageLoading.value = false);
    }
  }

  void _showReplyPopup({
    required Message message,
    required bool sentByCurrentUser,
  }) {
    final replyPopup = chatListConfig.replyPopupConfig;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(hours: 1),
          backgroundColor: replyPopup?.backgroundColor ?? Colors.white,
          content: replyPopup?.replyPopupBuilder != null
              ? replyPopup!.replyPopupBuilder!(message, sentByCurrentUser)
              : ReplyPopupWidget(
                  buttonTextStyle: replyPopup?.buttonTextStyle,
                  topBorderColor: replyPopup?.topBorderColor,
                  onMoreTap: () {
                    _onChatListTap();
                    replyPopup?.onMoreTap?.call(
                      message,
                      sentByCurrentUser,
                    );
                  },
                  onReportTap: () {
                    _onChatListTap();
                    replyPopup?.onReportTap?.call(
                      message,
                    );
                  },
                  onUnsendTap: () {
                    _onChatListTap();
                    replyPopup?.onUnsendTap?.call(
                      message,
                    );
                  },
                  onReplyTap: () {
                    widget.assignReplyMessage(message);
                    if (featureActiveConfig?.enableReactionPopup ?? false) {
                      chatViewIW?.showPopUp.value = false;
                    }
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (replyPopup?.onReplyTap != null) {
                      replyPopup?.onReplyTap!(message);
                    }
                  },
                  sentByCurrentUser: sentByCurrentUser,
                ),
          padding: EdgeInsets.zero,
        ),
      ).closed;
  }
}
