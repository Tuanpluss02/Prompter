import 'package:base/app/constants/app_strings.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/modules/ai_chat/components/chat_theme.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ai_chat_controller.dart';

class AiChatScreen extends BaseScreen<AiChatController> {
  const AiChatScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildScreen(BuildContext context) {
    ChatTheme theme = DarkChatTheme();
    return Obx(() => ChatView(
        chatController: controller.chatController,
        chatViewState: controller.chatViewState.value,
        onSendTap: controller.onTapSend,
        featureActiveConfig: const FeatureActiveConfig(
          enableReplySnackBar: false,
          enableSwipeToReply: false,
          lastSeenAgoBuilderVisibility: true,
          receiptsBuilderVisibility: true,
          enableScrollToBottomButton: true,
          enableCurrentUserProfileAvatar: true,
        ),
        scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
          backgroundColor: theme.textFieldBackgroundColor,
          border: Border.all(
            color: Colors.transparent,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.themeIconColor,
            weight: 10,
            size: 30,
          ),
        ),
        chatViewStateConfig: ChatViewStateConfiguration(
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: theme.outgoingChatBubbleColor,
          ),
          onReloadButtonTap: () {},
        ),
        typeIndicatorConfig: TypeIndicatorConfiguration(
          flashingCircleBrightColor: theme.flashingCircleBrightColor,
          flashingCircleDarkColor: theme.flashingCircleDarkColor,
        ),
        appBar: Obx(() => ChatViewAppBar(
              elevation: theme.elevation,
              backGroundColor: theme.appBarColor,
              backArrowColor: theme.backArrowColor,
              chatTitle: controller.selectedModel.value.displayName,
              chatTitleTextStyle: TextStyle(
                color: theme.appBarTitleTextStyle,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.25,
              ),
              userStatus: "Let's creat something awesome",
              userStatusTextStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            )),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          messageTimeIconColor: theme.messageTimeIconColor,
          messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: theme.chatHeaderColor,
              fontSize: 12,
            ),
          ),
          backgroundColor: theme.backgroundColor,
        ),
        sendMessageConfig: SendMessageConfiguration(
          textFieldConfig: TextFieldConfiguration(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            borderRadius: BorderRadius.circular(12),
            textStyle: TextStyle(color: theme.textFieldTextColor, fontSize: 16),
          ),
          allowRecordingVoice: false,
          enableCameraImagePicker: false,
          enableGalleryImagePicker: false,
          replyMessageColor: theme.replyMessageColor,
          defaultSendButtonColor: theme.sendButtonColor,
          replyDialogColor: theme.replyDialogColor,
          replyTitleColor: theme.replyTitleColor,
          textFieldBackgroundColor: theme.textFieldBackgroundColor,
          closeIconColor: theme.closeIconColor,
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              bodyStyle: theme.outgoingChatLinkBodyStyle,
              titleStyle: theme.outgoingChatLinkTitleStyle,
            ),
            receiptsWidgetConfig: const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
            color: theme.outgoingChatBubbleColor,
          ),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
                decoration: TextDecoration.underline,
              ),
              backgroundColor: theme.linkPreviewIncomingChatColor,
              bodyStyle: theme.incomingChatLinkBodyStyle,
              titleStyle: theme.incomingChatLinkTitleStyle?.copyWith(fontSize: 12),
            ),
            textStyle: TextStyle(color: theme.inComingChatBubbleTextColor, fontSize: 16),
            senderNameTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor, fontSize: 12),
            color: theme.inComingChatBubbleColor,
          ),
        ),
        replyPopupConfig: ReplyPopupConfiguration(
          backgroundColor: theme.replyPopupColor,
          buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor, fontSize: 12),
          topBorderColor: theme.replyPopupTopBorderColor,
        ),
        reactionPopupConfig: ReactionPopupConfiguration(
          overrideUserReactionCallback: true,
          shadow: BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
          ),
          userReactionCallback: controller.onReactionTap,
          backgroundColor: theme.reactionPopupColor,
        ),
        messageConfig: MessageConfiguration(
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: theme.messageReactionBackGroundColor,
            borderColor: theme.messageReactionBackGroundColor,
            reactedUserCountTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionCountTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
              backgroundColor: theme.backgroundColor,
              reactedUserTextStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
              ),
              reactionWidgetDecoration: BoxDecoration(
                color: theme.inComingChatBubbleColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 20),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          imageMessageConfig: ImageMessageConfiguration(
            hideShareIcon: true,
            height: 300,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            shareIconConfig: ShareIconConfiguration(
              defaultIconBackgroundColor: theme.shareIconBackgroundColor,
              defaultIconColor: theme.shareIconColor,
            ),
          ),
        ),
        profileCircleConfig: const ProfileCircleConfiguration(
          profileImageUrl: AppStrings.defaultNetworkAvatar,
        ),
        repliedMessageConfig: RepliedMessageConfiguration(
          backgroundColor: theme.repliedMessageColor,
          verticalBarColor: theme.verticalBarColor,
          repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
            enableHighlightRepliedMsg: true,
            highlightColor: Colors.pinkAccent.shade100,
            highlightScale: 1.1,
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),
          replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(
          onLeftSwipe: null,
          onRightSwipe: null,
          replyIconColor: theme.swipeToReplyIconColor,
        ),
        replySuggestionsConfig: ReplySuggestionsConfig(
          itemConfig: SuggestionItemConfig(
            decoration: BoxDecoration(
              color: theme.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.outgoingChatBubbleColor ?? Colors.white,
              ),
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        )));
  }
}
