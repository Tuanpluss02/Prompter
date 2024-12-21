import '../../utils/constants/constants.dart';
import '../../values/enumeration.dart';
import '../../values/typedefs.dart';

class ChatUser {
  /// Provides id of user.
  final String id;

  /// Provides name of user.
  final String name;

  /// Provides profile picture as network URL or asset of user.
  /// Or
  /// Provides profile picture's data in base64 string.
  final String? profilePhoto;

  /// Field to set default image if network url for profile image not provided
  final String defaultAvatarImage;

  /// Field to define image type [network, asset or base64]
  final ImageType imageType;

  /// Error builder to build error widget for asset image
  final AssetImageErrorBuilder? assetImageErrorBuilder;

  /// Error builder to build error widget for network image
  final NetworkImageErrorBuilder? networkImageErrorBuilder;

  /// Progress indicator builder for network image
  final NetworkImageProgressIndicatorBuilder? networkImageProgressIndicatorBuilder;

  ChatUser({
    required this.id,
    required this.name,
    this.profilePhoto,
    this.defaultAvatarImage = profileImage,
    this.imageType = ImageType.network,
    this.assetImageErrorBuilder,
    this.networkImageErrorBuilder,
    this.networkImageProgressIndicatorBuilder,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        name: json["name"],
        profilePhoto: json["profilePhoto"],
        imageType: ImageType.tryParse(json['imageType']?.toString()) ?? ImageType.network,
        defaultAvatarImage: json["defaultAvatarImage"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profilePhoto': profilePhoto,
        'imageType': imageType.name,
        'defaultAvatarImage': defaultAvatarImage,
      };

  ChatUser copyWith({
    String? id,
    String? name,
    String? profilePhoto,
    ImageType? imageType,
    String? defaultAvatarImage,
    bool forceNullValue = false,
  }) {
    return ChatUser(
      id: id ?? this.id,
      name: name ?? this.name,
      imageType: imageType ?? this.imageType,
      profilePhoto: forceNullValue ? profilePhoto : profilePhoto ?? this.profilePhoto,
      defaultAvatarImage: defaultAvatarImage ?? this.defaultAvatarImage,
    );
  }
}
