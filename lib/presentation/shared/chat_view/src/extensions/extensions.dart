import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:base/presentation/shared/chat_view/src/inherited_widgets/configurations_inherited_widgets.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/chat_view_inherited_widget.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/profile_image_widget.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/suggestions/suggestions_config_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants/constants.dart';
import '../utils/emoji_parser.dart';
import '../utils/package_strings.dart';

/// Extension on State for accessing inherited widget.
extension BuildContextExtension on BuildContext {
  ConfigurationsInheritedWidget get chatListConfig => mounted && ConfigurationsInheritedWidget.of(this) != null
      ? ConfigurationsInheritedWidget.of(this)!
      : const ConfigurationsInheritedWidget(
          chatBackgroundConfig: ChatBackgroundConfiguration(),
          child: SizedBox.shrink(),
        );

  ChatViewInheritedWidget? get chatViewIW => mounted ? ChatViewInheritedWidget.of(this) : null;

  ReplySuggestionsConfig? get suggestionsConfig => mounted ? SuggestionsConfigIW.of(this)?.suggestionsConfig : null;
}

/// Extension on nullable sting to return specific state string.
extension ChatViewStateTitleExtension on String? {
  String getChatViewStateTitle(ChatViewState state) {
    switch (state) {
      case ChatViewState.hasMessages:
        return this ?? '';
      case ChatViewState.noData:
        return this ?? 'No Messages';
      case ChatViewState.loading:
        return this ?? '';
      case ChatViewState.error:
        return this ?? 'Something went wrong !!';
    }
  }
}

/// Extension on ConnectionState for checking specific connection.
extension ConnectionStates on ConnectionState {
  bool get isActive => this == ConnectionState.active;

  bool get isWaiting => this == ConnectionState.waiting;
}

/// Extension on MessageType for checking specific message type
extension MessageTypes on MessageType {
  bool get isCustom => this == MessageType.custom;

  bool get isImage => this == MessageType.image;

  bool get isText => this == MessageType.text;

  bool get isVoice => this == MessageType.voice;
}

/// Extension on State for accessing inherited widget.
extension StatefulWidgetExtension on State {
  ConfigurationsInheritedWidget get chatListConfig => context.mounted && ConfigurationsInheritedWidget.of(context) != null
      ? ConfigurationsInheritedWidget.of(context)!
      : const ConfigurationsInheritedWidget(
          chatBackgroundConfig: ChatBackgroundConfiguration(),
          child: SizedBox.shrink(),
        );

  ChatViewInheritedWidget? get chatViewIW => context.mounted ? ChatViewInheritedWidget.of(context) : null;

  ReplySuggestionsConfig? get suggestionsConfig => context.mounted ? SuggestionsConfigIW.of(context)?.suggestionsConfig : null;
}

/// Extension for DateTime to get specific formats of dates and time.
extension TimeDifference on DateTime {
  String get getDateFromDateTime {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }

  String get getTimeFromDateTime => DateFormat.Hm().format(this);

  String getDay(String chatSeparatorDatePattern) {
    final differenceInDays = difference(DateTime.now()).inDays;
    if (differenceInDays == 0) {
      return PackageStrings.today;
    } else if (differenceInDays <= 1 && differenceInDays >= -1) {
      return PackageStrings.yesterday;
    } else {
      final DateFormat formatter = DateFormat(chatSeparatorDatePattern);
      return formatter.format(this);
    }
  }
}

/// Extension on String which implements different types string validations.
extension ValidateString on String {
  bool get fromMemory => startsWith('data:image');

  bool get isAllEmoji {
    for (String s in EmojiParser().unemojify(this).split(" ")) {
      if (!s.startsWith(":") || !s.endsWith(":")) {
        return false;
      }
    }
    return true;
  }

  bool get isImageUrl {
    final imageUrlRegExp = RegExp(imageUrlRegExpression);
    return imageUrlRegExp.hasMatch(this) || startsWith('data:image');
  }

  bool get isUrl => Uri.tryParse(this)?.isAbsolute ?? false;

  Widget getUserProfilePicture({
    required ChatUser? Function(String) getChatUser,
    double? profileCircleRadius,
    EdgeInsets? profileCirclePadding,
  }) {
    final user = getChatUser(this);
    return Padding(
      padding: profileCirclePadding ?? const EdgeInsets.only(left: 4),
      child: ProfileImageWidget(
        imageUrl: user?.profilePhoto,
        imageType: user?.imageType,
        defaultAvatarImage: user?.defaultAvatarImage ?? profileImage,
        circleRadius: profileCircleRadius ?? 8,
        assetImageErrorBuilder: user?.assetImageErrorBuilder,
        networkImageErrorBuilder: user?.networkImageErrorBuilder,
        networkImageProgressIndicatorBuilder: user?.networkImageProgressIndicatorBuilder,
      ),
    );
  }
}
