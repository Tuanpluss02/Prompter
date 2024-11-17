// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/entities/post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostEntityImpl _$$PostEntityImplFromJson(Map<String, dynamic> json) =>
    _$PostEntityImpl(
      id: json['id'] as String? ?? '',
      authorId: json['authorId'] as String? ?? '',
      authorAvatarUrl: json['authorAvatarUrl'] as String? ?? '',
      authorDisplayName: json['authorDisplayName'] as String? ?? '',
      authorUsername: json['authorUsername'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PostEntityImplToJson(_$PostEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorAvatarUrl': instance.authorAvatarUrl,
      'authorDisplayName': instance.authorDisplayName,
      'authorUsername': instance.authorUsername,
      'images': instance.images,
      'likeCount': instance.likeCount,
      'comments': instance.comments,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
