import 'package:base/presentation/shared/chat_view/src/controller/chat_controller.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/feature_active_config.dart';
import 'package:base/presentation/shared/chat_view/src/models/config_models/profile_circle_configuration.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/reaction_popup.dart';
import 'package:flutter/material.dart';

/// This widget for alternative of excessive amount of passing arguments
/// over widgets.
class ChatViewInheritedWidget extends InheritedWidget {
  final FeatureActiveConfig featureActiveConfig;
  final ProfileCircleConfiguration? profileCircleConfiguration;
  final ChatController chatController;
  final GlobalKey chatTextFieldViewKey = GlobalKey();
  final ValueNotifier<bool> showPopUp = ValueNotifier(false);
  final GlobalKey<ReactionPopupState> reactionPopupKey = GlobalKey();
  ChatViewInheritedWidget({
    super.key,
    required super.child,
    required this.featureActiveConfig,
    required this.chatController,
    this.profileCircleConfiguration,
  });

  @override
  bool updateShouldNotify(covariant ChatViewInheritedWidget oldWidget) => oldWidget.featureActiveConfig != featureActiveConfig;

  static ChatViewInheritedWidget? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ChatViewInheritedWidget>();
}
