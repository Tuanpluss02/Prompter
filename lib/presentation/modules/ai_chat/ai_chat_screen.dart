import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_enums.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/ai_chat/components/chat_theme.dart';
import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'ai_chat_controller.dart';

class AiChatScreen extends BaseScreen<AiChatController> {
  const AiChatScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    ChatTheme theme = DarkChatTheme();
    return Obx(() => ChatView(
        chatController: controller.chatController,
        chatViewState: controller.chatViewState.value,
        onSendTap: controller.onTapSend,
        featureActiveConfig: const FeatureActiveConfig(
          enableReplySnackBar: false,
          enableReactionPopup: false,
          enableSwipeToReply: false,
          lastSeenAgoBuilderVisibility: true,
          receiptsBuilderVisibility: false,
          enableDoubleTapToLike: false,
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
          indicatorSize: 5,
          flashingCircleBrightColor: theme.flashingCircleBrightColor,
          flashingCircleDarkColor: theme.flashingCircleDarkColor,
        ),
        appBar: Container(
            color: AppColors.backgroundColor,
            child: Row(
              children: [
                AppBackButton(size: 40, margin: const EdgeInsets.only(left: 16)),
                const SizedBox(width: 16),
                SizedBox(
                  width: Get.width * 0.6,
                  child: CustomDropdown<String>(
                      maxlines: 2,
                      initialItem: controller.selectedModel.value.displayName,
                      onChanged: (String? newValue) {
                        controller.selectedModel.value = GenerativeAiModel.values.firstWhere((element) => element.displayName == newValue);
                      },
                      items: GenerativeAiModel.values.map((e) => e.displayName).toList(),
                      decoration: CustomDropdownDecoration(
                        headerStyle: AppTextStyles.s20w700,
                        closedFillColor: Colors.transparent,
                        expandedFillColor: AppColors.backgroundColor,
                      )),
                ),
              ],
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
          sendButtonIcon: SvgPicture.asset(SvgPath.icSend),
          textFieldConfig: TextFieldConfiguration(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            borderRadius: BorderRadius.circular(16),
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
            borderRadius: BorderRadius.circular(16),
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              padding: EdgeInsets.zero,
              linkStyle: AppTextStyles.s16w400,
              titleStyle: AppTextStyles.s14w600,
              bodyStyle: AppTextStyles.s12w400,
            ),
            receiptsWidgetConfig: const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
            color: theme.outgoingChatBubbleColor,
          ),
          inComingChatBubbleConfig: ChatBubble(
            borderRadius: BorderRadius.circular(16),
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              padding: EdgeInsets.zero,
              linkStyle: AppTextStyles.s16w400,
              titleStyle: AppTextStyles.s14w600,
              bodyStyle: AppTextStyles.s12w400,
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
          replyPopupBuilder: (Message message, bool isOutgoing) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.replyPopupColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Copy', style: TextStyle(color: theme.replyPopupButtonColor)),
                ],
              ),
            );
          },
        ),
        messageConfig: MessageConfiguration(
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
