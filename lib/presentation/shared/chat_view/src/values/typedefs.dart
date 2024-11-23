import 'package:base/presentation/shared/chat_view/src/models/data_models/chat_user.dart';
import 'package:base/presentation/shared/chat_view/src/models/data_models/message.dart';
import 'package:base/presentation/shared/chat_view/src/models/data_models/reply_message.dart';
import 'package:base/presentation/shared/chat_view/src/models/data_models/suggestion_item_data.dart';
import 'package:base/presentation/shared/chat_view/src/values/enumeration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

typedef AssetImageErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
);

/// customMessageType view for a reply of custom message type
typedef CustomMessageReplyViewBuilder = Widget Function(
  ReplyMessage state,
);

/// customView for replying to any message
typedef CustomViewForReplyMessage = Widget Function(
  BuildContext context,
  ReplyMessage state,
);
typedef DoubleCallBack = void Function(double, double);
typedef DragUpdateDetailsCallback = void Function(DragUpdateDetails);
typedef GetMessageSeparator = (Map<int, DateTime>, DateTime);
typedef MessageCallBack = void Function(Message message);
typedef MessageSorter = int Function(
  Message message1,
  Message message2,
);
typedef MoreTapCallBack = void Function(
  Message message,
  bool sentByCurrentUser,
);
typedef NetworkImageErrorBuilder = Widget Function(
  BuildContext context,
  String url,
  Object error,
);
typedef NetworkImageProgressIndicatorBuilder = Widget Function(
  BuildContext context,
  String url,
  DownloadProgress progress,
);
typedef ReactedUserCallback = void Function(
  ChatUser reactedUser,
  String reaction,
);
typedef ReactionCallback = void Function(
  Message message,
  String emoji,
);
typedef ReplyMessageCallBack = void Function(ReplyMessage replyMessage);

typedef ReplyMessageWithReturnWidget = Widget Function(
  ReplyMessage? replyMessage,
);
typedef StringCallback = void Function(String);

typedef StringMessageCallBack = void Function(
  String message,
  ReplyMessage replyMessage,
  MessageType messageType,
);
typedef StringsCallBack = void Function(String emoji, String messageId);
typedef StringWithReturnWidget = Widget Function(String separator);
typedef SuggestionItemBuilder = Widget Function(
  int index,
  SuggestionItemData suggestionItemData,
);
typedef VoidCallBack = void Function();
typedef VoidCallBackWithFuture = Future<void> Function();
