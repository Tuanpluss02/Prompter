import 'dart:io' if (kIsWeb) 'dart:html';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../chatview.dart';
import '../utils/constants/constants.dart';
import 'profile_image_widget.dart';

class ChatViewAppBar extends StatelessWidget {
  /// Allow user to change colour of appbar.
  final Color? backGroundColor;

  /// Allow user to change title of appbar.
  final String chatTitle;

  /// Allow user to change whether user is available or offline.
  final String? userStatus;

  /// Allow user to change profile picture in appbar.
  final String? profilePicture;

  /// Allow user to change text style of chat title.
  final TextStyle? chatTitleTextStyle;

  /// Allow user to change text style of user status.
  final TextStyle? userStatusTextStyle;

  /// Allow user to change back arrow colour.
  final Color? backArrowColor;

  /// Allow user to add actions widget in right side of appbar.
  final List<Widget>? actions;

  /// Allow user to change elevation of appbar.
  final double? elevation;

  /// Provides callback when user tap on back arrow.
  final VoidCallBack? onBackPress;

  /// Allow user to change padding in appbar.
  final EdgeInsets? padding;

  /// Allow user to change leading icon of appbar.
  final Widget? leading;

  /// Allow user to turn on/off leading icon.
  final bool showLeading;

  /// Field to set default image if network url for profile image not provided
  final String defaultAvatarImage;

  /// Error builder to build error widget for asset image
  final AssetImageErrorBuilder? assetImageErrorBuilder;

  /// Error builder to build error widget for network image
  final NetworkImageErrorBuilder? networkImageErrorBuilder;

  /// Field to define image type [network, asset or base64]
  final ImageType imageType;

  /// Progress indicator builder for network image
  final NetworkImageProgressIndicatorBuilder? networkImageProgressIndicatorBuilder;

  const ChatViewAppBar({
    super.key,
    required this.chatTitle,
    this.backGroundColor,
    this.userStatus,
    this.profilePicture,
    this.chatTitleTextStyle,
    this.userStatusTextStyle,
    this.backArrowColor,
    this.actions,
    this.elevation,
    this.onBackPress,
    this.padding,
    this.leading,
    this.showLeading = true,
    this.defaultAvatarImage = profileImage,
    this.assetImageErrorBuilder,
    this.networkImageErrorBuilder,
    this.imageType = ImageType.network,
    this.networkImageProgressIndicatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 1,
      child: Container(
        padding: padding ??
            EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 4,
            ),
        color: backGroundColor ?? Colors.white,
        child: Row(
          children: [
            if (showLeading)
              leading ??
                  IconButton(
                    onPressed: onBackPress ?? () => Navigator.pop(context),
                    icon: Icon(
                      (!kIsWeb && Platform.isIOS) ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: backArrowColor,
                    ),
                  ),
            Expanded(
              child: Row(
                children: [
                  if (profilePicture != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ProfileImageWidget(
                        imageUrl: profilePicture,
                        defaultAvatarImage: defaultAvatarImage,
                        assetImageErrorBuilder: assetImageErrorBuilder,
                        networkImageErrorBuilder: networkImageErrorBuilder,
                        imageType: imageType,
                        networkImageProgressIndicatorBuilder: networkImageProgressIndicatorBuilder,
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatTitle,
                        style: chatTitleTextStyle ??
                            const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.25,
                            ),
                      ),
                      if (userStatus != null)
                        Text(
                          userStatus!,
                          style: userStatusTextStyle,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}
