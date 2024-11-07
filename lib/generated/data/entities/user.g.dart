// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      postCount: (json['postCount'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'bio': instance.bio,
      'followers': instance.followers,
      'following': instance.following,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'postCount': instance.postCount,
      'likeCount': instance.likeCount,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      postCount: (json['postCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'bio': instance.bio,
      'followers': instance.followers,
      'following': instance.following,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'postCount': instance.postCount,
      'likeCount': instance.likeCount,
    };
