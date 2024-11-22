import 'dart:io';

import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/inherited_widgets/configurations_inherited_widgets.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/chat_list_widget.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/chat_view_inherited_widget.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/chatview_state_widget.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/reaction_popup.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/suggestions/suggestions_config_inherited_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../values/custom_time_messages.dart';
import 'send_message_widget.dart';

class ChatView extends StatefulWidget {
  /// Provides configuration related to user profile circle avatar.
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Provides configurations related to chat bubble such as padding, margin, max
  /// width etc.
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Allow user to giving customisation different types
  /// messages.
  final MessageConfiguration? messageConfig;

  /// Provides configuration for replied message view which is located upon chat
  /// bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides configurations related to swipe chat bubble which triggers
  /// when user swipe chat bubble.
  final SwipeToReplyConfiguration? swipeToReplyConfig;

  /// Provides configuration for reply snack bar's appearance and options.
  final ReplyPopupConfiguration? replyPopupConfig;

  /// Provides configuration for reaction pop up appearance.
  final ReactionPopupConfiguration? reactionPopupConfig;

  /// Allow user to give customisation to background of chat
  final ChatBackgroundConfiguration chatBackgroundConfig;

  /// Provides callback when user actions reaches to top and needs to load more
  /// chat
  final VoidCallBackWithFuture? loadMoreData;

  /// Provides widget for loading view while pagination is enabled.
  final Widget? loadingWidget;

  /// Provides flag if there is no more next data left in list.
  final bool? isLastPage;

  /// Provides call back when user tap on send button in text field. It returns
  /// message, reply message and message type.
  final StringMessageCallBack? onSendTap;

  /// Provides builder which helps you to make custom text field and functionality.
  final ReplyMessageWithReturnWidget? sendMessageBuilder;

  /// Allow user to giving customisation typing indicator.
  final TypeIndicatorConfiguration? typeIndicatorConfig;

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides configuration of default text field in chat.
  final SendMessageConfiguration? sendMessageConfig;

  /// Provides current state of chat.
  final ChatViewState chatViewState;

  /// Provides configuration for chat view state appearance and functionality.
  final ChatViewStateConfiguration? chatViewStateConfig;

  /// Provides configuration for turn on/off specific features.
  final FeatureActiveConfig featureActiveConfig;

  /// Provides parameter so user can assign ChatViewAppbar.
  final Widget? appBar;

  /// Provides callback when user tap on chat list.
  final VoidCallBack? onChatListTap;

  /// Configuration for emoji picker sheet
  final Config? emojiPickerSheetConfig;

  /// Suggestion Item Config
  final ReplySuggestionsConfig? replySuggestionsConfig;

  /// Provides a callback for the view when replying to message
  final CustomViewForReplyMessage? replyMessageBuilder;

  /// Provides a configuration for scroll to bottom button config
  final ScrollToBottomButtonConfig? scrollToBottomButtonConfig;

  const ChatView({
    super.key,
    required this.chatController,
    this.onSendTap,
    this.profileCircleConfig,
    this.chatBubbleConfig,
    this.repliedMessageConfig,
    this.swipeToReplyConfig,
    this.replyPopupConfig,
    this.reactionPopupConfig,
    this.loadMoreData,
    this.loadingWidget,
    this.messageConfig,
    this.isLastPage,
    this.appBar,
    ChatBackgroundConfiguration? chatBackgroundConfig,
    this.typeIndicatorConfig,
    this.sendMessageBuilder,
    this.sendMessageConfig,
    this.onChatListTap,
    required this.chatViewState,
    ChatViewStateConfiguration? chatViewStateConfig,
    this.featureActiveConfig = const FeatureActiveConfig(),
    this.emojiPickerSheetConfig,
    this.replyMessageBuilder,
    this.replySuggestionsConfig,
    this.scrollToBottomButtonConfig,
  })  : chatBackgroundConfig = chatBackgroundConfig ?? const ChatBackgroundConfiguration(),
        chatViewStateConfig = chatViewStateConfig ?? const ChatViewStateConfiguration();

  @override
  State<ChatView> createState() => _ChatViewState();

  static void closeReplyMessageView(BuildContext context) {
    final state = context.findAncestorStateOfType<_ChatViewState>();
    if (state == null) return;

    state.replyMessageViewClose();
  }
}

class _ChatViewState extends State<ChatView> with SingleTickerProviderStateMixin {
  final GlobalKey<SendMessageWidgetState> _sendMessageKey = GlobalKey();
  ValueNotifier<ReplyMessage> replyMessage = ValueNotifier(const ReplyMessage());

  ChatBackgroundConfiguration get chatBackgroundConfig => widget.chatBackgroundConfig;

  ChatController get chatController => widget.chatController;

  ChatViewState get chatViewState => widget.chatViewState;

  ChatViewStateConfiguration? get chatViewStateConfig => widget.chatViewStateConfig;

  FeatureActiveConfig get featureActiveConfig => widget.featureActiveConfig;

  @override
  Widget build(BuildContext context) {
    // Scroll to last message on in hasMessages state.
    if (widget.chatController.showTypingIndicator && chatViewState.hasMessages) {
      chatController.scrollToLastMessage();
    }
    return ChatViewInheritedWidget(
      chatController: chatController,
      featureActiveConfig: featureActiveConfig,
      profileCircleConfiguration: widget.profileCircleConfig,
      child: SuggestionsConfigIW(
        suggestionsConfig: widget.replySuggestionsConfig,
        child: Builder(builder: (context) {
          return ConfigurationsInheritedWidget(
            chatBackgroundConfig: widget.chatBackgroundConfig,
            reactionPopupConfig: widget.reactionPopupConfig,
            typeIndicatorConfig: widget.typeIndicatorConfig,
            chatBubbleConfig: widget.chatBubbleConfig,
            replyPopupConfig: widget.replyPopupConfig,
            messageConfig: widget.messageConfig,
            profileCircleConfig: widget.profileCircleConfig,
            repliedMessageConfig: widget.repliedMessageConfig,
            swipeToReplyConfig: widget.swipeToReplyConfig,
            emojiPickerSheetConfig: widget.emojiPickerSheetConfig,
            scrollToBottomButtonConfig: widget.scrollToBottomButtonConfig,
            child: Stack(
              children: [
                Container(
                  height: chatBackgroundConfig.height ?? MediaQuery.of(context).size.height,
                  width: chatBackgroundConfig.width ?? MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: chatBackgroundConfig.backgroundColor ?? Colors.white,
                    image: chatBackgroundConfig.backgroundImage != null
                        ? DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(chatBackgroundConfig.backgroundImage!),
                          )
                        : null,
                  ),
                  padding: chatBackgroundConfig.padding,
                  margin: chatBackgroundConfig.margin,
                  child: Column(
                    children: [
                      if (widget.appBar != null) widget.appBar!,
                      Expanded(
                        child: Stack(
                          children: [
                            if (chatViewState.isLoading)
                              ChatViewStateWidget(
                                chatViewStateWidgetConfig: chatViewStateConfig?.loadingWidgetConfig,
                                chatViewState: chatViewState,
                              )
                            else if (chatViewState.noMessages)
                              ChatViewStateWidget(
                                chatViewStateWidgetConfig: chatViewStateConfig?.noMessageWidgetConfig,
                                chatViewState: chatViewState,
                                onReloadButtonTap: chatViewStateConfig?.onReloadButtonTap,
                              )
                            else if (chatViewState.isError)
                              ChatViewStateWidget(
                                chatViewStateWidgetConfig: chatViewStateConfig?.errorWidgetConfig,
                                chatViewState: chatViewState,
                                onReloadButtonTap: chatViewStateConfig?.onReloadButtonTap,
                              )
                            else if (chatViewState.hasMessages)
                              ValueListenableBuilder<ReplyMessage>(
                                valueListenable: replyMessage,
                                builder: (_, state, child) {
                                  return ChatListWidget(
                                    replyMessage: state,
                                    chatController: widget.chatController,
                                    loadMoreData: widget.loadMoreData,
                                    isLastPage: widget.isLastPage,
                                    loadingWidget: widget.loadingWidget,
                                    onChatListTap: widget.onChatListTap,
                                    assignReplyMessage: (message) => _sendMessageKey.currentState?.assignReplyMessage(message),
                                  );
                                },
                              ),
                            if (featureActiveConfig.enableTextField)
                              SendMessageWidget(
                                key: _sendMessageKey,
                                sendMessageBuilder: widget.sendMessageBuilder,
                                sendMessageConfig: widget.sendMessageConfig,
                                onSendTap: (message, replyMessage, messageType) {
                                  if (context.suggestionsConfig?.autoDismissOnSelection ?? true) {
                                    chatController.removeReplySuggestions();
                                  }
                                  _onSendTap(message, replyMessage, messageType);
                                },
                                onReplyCallback: (reply) => replyMessage.value = reply,
                                onReplyCloseCallback: () => replyMessage.value = const ReplyMessage(),
                                messageConfig: widget.messageConfig,
                                replyMessageBuilder: widget.replyMessageBuilder,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (featureActiveConfig.enableReactionPopup)
                  ValueListenableBuilder<bool>(
                    valueListenable: context.chatViewIW!.showPopUp,
                    builder: (_, showPopupValue, child) {
                      return ReactionPopup(
                        key: context.chatViewIW!.reactionPopupKey,
                        onTap: () => _onChatListTap(context),
                        showPopUp: showPopupValue,
                      );
                    },
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    replyMessage.dispose();
    chatViewIW?.showPopUp.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setLocaleMessages('en', ReceiptsCustomMessages());
  }

  void replyMessageViewClose() => _sendMessageKey.currentState?.onCloseTap();

  void _assignReplyMessage() {
    if (replyMessage.value.message.isNotEmpty) {
      replyMessage.value = const ReplyMessage();
    }
  }

  void _onChatListTap(BuildContext context) {
    widget.onChatListTap?.call();
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      FocusScope.of(context).unfocus();
    }
    context.chatViewIW?.showPopUp.value = false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    if (widget.sendMessageBuilder == null) {
      if (widget.onSendTap != null) {
        widget.onSendTap!(message, replyMessage, messageType);
      }
      _assignReplyMessage();
    }
    chatController.scrollToLastMessage();
  }
}